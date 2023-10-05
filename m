Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C737BA9E1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjJETRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJETRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:17:19 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7B7CE;
        Thu,  5 Oct 2023 12:17:19 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1dd71c0a41fso791108fac.2;
        Thu, 05 Oct 2023 12:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696533437; x=1697138237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqirAhdhlifzlWSmYkNBUWfnYzjdjuk6xxAE0rOCESk=;
        b=jLqspYxR4nETSW5PTui2+dPPzX68mGGUKGQcw8rbHH/We4uEQCO3s5mftsUdnr7mYX
         XOp0ZPP//V6FL8Tu81ydBkUMy5HSQteNyflwMLbPD07dEXL6qiz/Ei9g625L8o1271QJ
         umgEiDHTsXrIdV4schVEQcniboMSSBxybIq1pExdW+ZOTmeU/mwLap/5RhZLVjhAqwCm
         sff4GaSSWKTo20bFvnbV3n3yRr0CIuhs5op0BQAoK6iByab4JpaGSMtgHGA51AUAfP9P
         iXtMkVTEFzaKMvPUP2hi934OtPyJZOch5t/MyN3mmMjzYMrZLcga6iZ8T6Xo+3132W5c
         WD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696533437; x=1697138237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqirAhdhlifzlWSmYkNBUWfnYzjdjuk6xxAE0rOCESk=;
        b=MNIYoRG5/3pl+MIsdpuzEFOsshNOudGMgSrt5vRz5Lr1iE8yy81oFVw29mChsiuMDB
         dK2362+vtOtSn4pFy7T7VhB/ZrJWRf+kPzSZtg6bnp+aBjKaamYtzX86Mna3MUij0dRV
         meNXm9tdPBubfSoTiCr1+2nwvF1h3VfHxeoIG+3d8T/uwXhEjyZMq7dQfoJ/CY/EkFO+
         AFmR0sGvzHoberpZt4689b413+0ii423hVP87/V7iPGwt4TKN5RLl9pnniZ+yarkZ0NJ
         Ax2TnNbHJyKUp/B76oo7OaYBSV7n/CYaRj7m/lZLurrulgJlTHTTjVb+QADL7T+6HRrD
         /uSg==
X-Gm-Message-State: AOJu0YxGZKVH+uaS/K49SMLrt/fJFF3Eh/lorAEjhKKtu4+ZtEsew3lu
        Mu1h0mFqMwj59SSdwaWCOXbD547YLNdBV+SAnHY=
X-Google-Smtp-Source: AGHT+IE9blaE8fKYMPW45SEpXrubpwaapIeDOKnbcoknHheWjAVJiN+4m5TQBB5p+A2vaUi+VAlbFj5qOlq3oinBPvU=
X-Received: by 2002:a05:6870:560a:b0:1d6:79e2:8484 with SMTP id
 m10-20020a056870560a00b001d679e28484mr6961566oao.22.1696533436945; Thu, 05
 Oct 2023 12:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231005175230.232764-1-mario.limonciello@amd.com>
 <20231005175230.232764-3-mario.limonciello@amd.com> <2023100547-vitamins-detergent-4d18@gregkh>
In-Reply-To: <2023100547-vitamins-detergent-4d18@gregkh>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 5 Oct 2023 15:17:05 -0400
Message-ID: <CADnq5_MDxwJBvxvy9AohKn+Nu4NPs2kQVS4AwYyscdV41KDoQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Revert "drm/amd/pm: workaround for the wrong ac
 power detection on smu 13.0.0"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 3:13=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 05, 2023 at 12:52:30PM -0500, Mario Limonciello wrote:
> > This reverts commit 0e5e1a84f0b8c814d502a135824244127fed8f23.
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> No explaination as to why this needs to be reverted?  And does this need
> to be backported anywhere?

This patch ultimately never went upstream, but there was some
confusion about whether it did or not.  It can be ignored.

Alex
