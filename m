Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7DC7BDEDB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376477AbjJINXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376443AbjJINXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:23:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15F794
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:23:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso12940a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696857824; x=1697462624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUlrF6eVI5CzGWdW4qZHoHie28nfjSTSRnsJxxWevYM=;
        b=lm2IAsiOWr7PyBoAl7bNIcMp33+WyKqEfDzx3BZ8JkRewzS1eCXvNsQk1BMhcuesjL
         SSdUaqd8GqXSmCOkzDVfIMzBkD2RJ/nZcB+GnIKFOkqs64PyW9KTDzcMG76zONYPOknV
         3WUmCPprYbuVutnX8EybIGBc8kwtDETZnnxtC75+jGt87SN/s1/E/DyFHRzpZSf91UTI
         EJIueYp6uSvB6BO2vB4FhZrz2l8kQueMbkcDZB+JsqSDzqtpb0BXslJjNTzwgaCxEw0z
         6J8cVaD9CxTrJWgRzBSRFwceaqLokpdPK78kDNTsHdDlvpp96H3xKWlADv4iyb4bGXmB
         f42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696857824; x=1697462624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUlrF6eVI5CzGWdW4qZHoHie28nfjSTSRnsJxxWevYM=;
        b=YtDtmuiQX3KrrV5MSpUsx+0SEx0kInYWJ8Xuz4WolblotGi3jjBR1D7pdEJoOCrEHo
         wKi3jiELvuUrWxNQAqh7vv4j1v0fRUFFAf/YnT6ALh57w78Z8XUz/JXYLc8DnzlhucTZ
         /iIBVeD79LMhdSwnztT9c+qC3tSWXXncCyCKZ4INPBjP+gMVtcdtZ7ot6LjcF0rx9wRy
         PFQ2VBXifyPpdJ9Rbw5a1Ng5oY72XtFXHGA1GyYZOZIcOoWINO4pUel5QHegrN3LOsN7
         J0btqmj4yQ4Hz88DEWfFyW8Zy7bm25O0DOkHQyihA3FluCzvtTXZ9dTog07yvkPfM03a
         NGEQ==
X-Gm-Message-State: AOJu0Yxl8lR5tlXJHBhDYYuIP5VsJCcTPkJazNNYKps9TmOhcqmgp+d5
        xgivxQldNT+zS4GGg8yPcVZ++FB0Ty83qh8DaRdLmA==
X-Google-Smtp-Source: AGHT+IEERXwOrX1YQV0elIdWkUVnhhst9NzscoQY6rKnNsI3jYL7jiXNsex6lvmbobXMgSxWeRTVaJacN2q/vKq1VKA=
X-Received: by 2002:a50:9b1d:0:b0:525:573c:643b with SMTP id
 o29-20020a509b1d000000b00525573c643bmr366678edi.7.1696857824204; Mon, 09 Oct
 2023 06:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230925200110.1979606-1-zokeefe@google.com> <20231006105810.17fcb352e33cbcab1645099b@linux-foundation.org>
 <0ed83331-9037-421a-d450-363e07e87f6a@redhat.com> <20231006121105.69a1f32753dad00b993e2547@linux-foundation.org>
 <22ff3362-83fc-46c6-9412-15ca36c51d54@arm.com>
In-Reply-To: <22ff3362-83fc-46c6-9412-15ca36c51d54@arm.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 9 Oct 2023 06:23:09 -0700
Message-ID: <CAAa6QmRcqmw1_UL--mj2HC-GxvJG1NibVi=03+ahri_DzEp5Mw@mail.gmail.com>
Subject: Re: [PATCH v4] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
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

On Fri, Oct 6, 2023 at 2:28=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 06/10/2023 20:11, Andrew Morton wrote:
> > On Fri, 6 Oct 2023 20:52:30 +0200 David Hildenbrand <david@redhat.com> =
wrote:
> >
> >>> And as I don't know what is the urgency of this patch ("mm/thp: fix
> >>> "mm: thp: kill __transhuge_page_enabled()"), I'm unable to decide whi=
ch
> >>> patch needs to come first (thus requiring rework of the other patch).
> >>>
> >>> Please discuss!
> >>
> >> IMHO clearly this one.
> >
> > OK.  I'll drop the "variable-order, large folios for anonymous memory" =
v6
> > series for now.
>
> Yep, agreed!

Thank all and sorry for the late response ; have been buried as of late.

Best,
Zach
