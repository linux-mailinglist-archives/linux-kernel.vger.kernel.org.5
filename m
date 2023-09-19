Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7927A63D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjISMx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjISMxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:53:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AC699
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:53:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c4084803f1so233115ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695127999; x=1695732799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lh+1sUU5dkTYoSEM2fXg36LnHxaVihwfzF5o4t+hpHg=;
        b=dqkdnXmjNDa1xaVqKS7T+HLMOUGB5vu35FgQMuzN4SKtR6+6wikuJvqAGgLi9hUbNl
         ia09XQupJy9VjN2iZOInZMfEdfs2AP236XHumQZsQA1V0ItH3BFokDBLwx7XEYTADUyj
         YyIqs4YuMthtGlini/xcpChnrz2oVrJ1tutfcqNYI91sVNgKpa3AZPV3dzGwZN88812Y
         KBfNm/Rts5SJR4/9oe+9vrF06eqjNjQ9V+o9+dI8MfizdHiU1kJo7IEwZWpURfWM3F/p
         nFOMhGxcOTLTqCzmJ05/S5rzY7UtKMjuoVhGxyIsyOEMx4aL7xXhLGznNPJlSvZbmHZZ
         nzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127999; x=1695732799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lh+1sUU5dkTYoSEM2fXg36LnHxaVihwfzF5o4t+hpHg=;
        b=tLLwbVYV1DeK09CpvHlOHga7Lm1V9VPDXoJ+w4z2XCH74IW9bOAozgUi8MkWiTJVXY
         bcQyfkICeOj8ufW1Ma1+JztldunMaU9lT0fff/0W3yYY2wP1ptgRDg5Usm1EVbW9MQ8c
         +UPj9g2W/kwTtszotAM9tMMWOR2RdbCEUCwYbb8raR265qNBMjyuHbOUysJoLwWgzynx
         Wfo0Lm59HnjNUVJTBEHGoNwYvaQLCfdNtxZaobA7byBOo5HcqLhxu2rVYbh5MZpAzBKF
         K1lUeNCvhDTgk0XBpwu0W9Ja+5785RWhril9qWVgQLUudTPE1EwjZfy+ZjM8BTgXx1U5
         gBCg==
X-Gm-Message-State: AOJu0YwZ1zXUU1o79oH0RlHptnWQl8Yli2W4w4q40V/HB8GLm3P6P+1B
        6BDT8JbtJwOPAR1RxT2vrSibpltYaNcfLpMUJV2HRg==
X-Google-Smtp-Source: AGHT+IEqDMzMcSi/UF3bltYluqLNlHyl1vwohHUYGtLYY0Tt4jJ2SYOMUxpwYtPOHseSbOQ2Bb7mQCLAVETCNm1IIEw=
X-Received: by 2002:a17:902:e841:b0:1bb:a6de:8e5d with SMTP id
 t1-20020a170902e84100b001bba6de8e5dmr223823plg.4.1695127998571; Tue, 19 Sep
 2023 05:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
 <35f05064-a412-ad29-5352-277fb147bbc4@intel.com> <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com> <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com> <ZOkU+d4AsLGSAG+y@agluck-desk3>
 <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com> <ZOlRNTq3lE7VNHjU@agluck-desk3>
 <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com> <ZPjDHN0nvHz9kWFn@agluck-desk3>
In-Reply-To: <ZPjDHN0nvHz9kWFn@agluck-desk3>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 19 Sep 2023 14:53:07 +0200
Message-ID: <CALPaoCj_oa=nATvOO_uysYvu+PdTQtd0pvssvm9_M1+fP-Z8JA@mail.gmail.com>
Subject: Re: resctrl2 - status
To:     Tony Luck <tony.luck@intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Wed, Sep 6, 2023 at 8:21=E2=80=AFPM Tony Luck <tony.luck@intel.com> wrot=
e:
> I've just pushed an updated set of patches to:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git resctrl_v6=
5

I'm trying to understand the purpose of the resctrl_resource struct
defined here:

https://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git/tree/include=
/linux/resctrl.h?h=3Dresctrl2_v65#n356

From the common fields, it seems to be something with a name and some
info files that can be divided into domains and should be told when
CPUs are hotplugged. (I skipped the scope field because I couldn't
find any references outside fs/resctrl2/arch). The remaining fields
are explicitly disjoint depending on whether we're talking about
monitoring or allocation.

From this I don't get a strong sense that a "resource" is really a
thing and I think James's resctrl_schema struct only for the purpose
of resource allocation was more the right direction for common code.
Outwardly, resctrl groups seem to be the only thing relating
monitoring to allocation.

Is there a good reason for the common code to understand relationships
between monitors and schemas with the same name? If not, I think it
would make more sense to register monitors and control schemata
independently.

-Peter
