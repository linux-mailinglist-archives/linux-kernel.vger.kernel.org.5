Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7827E8163
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346015AbjKJS1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346120AbjKJS0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:26:11 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6D439CFB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:52:40 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so3420525a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699627959; x=1700232759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQ7Rhena6ScCQdnpHqD45MYtq7t/sNqUxa3XG6EBxPI=;
        b=UVisWwdSrrJQqfMHvvvLVp4T6L2+Oa6gKGoyFpWCgdSMs3bd3wOAF6sJ6NfP9Z7ZSJ
         WBwcUMecs/dsBSVRhu8hC9Z+HLVAfi8WUi73zNiLhyoSuFAIZ5t4PNvuoBC4V0WHsMG1
         Wz97E6gRQofzePzYafI4/9CB4ZW1V0VTeXo6PeOYo45IMTif3MCfmWnapRsEWVdzq1eD
         LIdMJQY7plELncEhZ8V92ZOX68GRKjtU1MchpZQ6VeuWxi0fmn0mr4Nuq7DVGud/8W/q
         OFuVNvFsrsjgNwGsnFJsTEnfA87MxL/5PE98fXqTo2OMUmlTwbmecEZN2Go6fCTaNU74
         T+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627959; x=1700232759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQ7Rhena6ScCQdnpHqD45MYtq7t/sNqUxa3XG6EBxPI=;
        b=bV/SX8FyumzD9h9D+AdfrPo4RdP6wVKqCtMO/3Pf85JXnV6cvvfZ4m25TD4FQzyMjK
         RkcylUNWJOGssmatuVG1kx+ArmajPzxhiV/ICdI1C2voJtj8bwqHsm2W7diIvepXzM+Y
         WTv4xjafpuh/b9pv4iZghAza64xCNt1ilATEOZjfBG3IaISucZlLGWvr1F2pHshrNM+m
         GI/i4Ki8bp0P9U1gHkXYztNORYGf/C65LRa84UOqoj6UC8FBN9q0353pcNdxOQqqBbp1
         9IYEN89fnrk/eyBMnUfVWhv9IMQ1wEKWYEIzw3dKjjI8DsPyqKjIeYWTEFsBMej+E8f5
         2MGg==
X-Gm-Message-State: AOJu0YzLlguLTi5SKQux2WIblbA6zSawmpM0QhgONqJLyQMeKypuwMsq
        sFDBpjYz2pgh8SBOby8aZXIDBCMth3uLlkPXsp/s
X-Google-Smtp-Source: AGHT+IFWiIFpLWNdqiv+jyMTi2WRpgU7mnTuKjO1edSyWbmAZ5QBDlL1vQ3USQb7E+TrDbJ9t/WQabRO+ZwAUE6XTNQ=
X-Received: by 2002:a50:ba89:0:b0:530:77e6:849f with SMTP id
 x9-20020a50ba89000000b0053077e6849fmr7055858ede.27.1699627959321; Fri, 10 Nov
 2023 06:52:39 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-11-lb@semihalf.com>
 <CAJfuBxxVGaqG4wVu-kM3ynA8ARTD6DFPBuz0a1GqunMqdvRBgQ@mail.gmail.com>
In-Reply-To: <CAJfuBxxVGaqG4wVu-kM3ynA8ARTD6DFPBuz0a1GqunMqdvRBgQ@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Fri, 10 Nov 2023 15:52:28 +0100
Message-ID: <CAK8ByeL9UJzNr=kAdyHZcdt6-B8c57OxUW+ccm4GmLrW26CxDg@mail.gmail.com>
Subject: Re: [PATCH v1 10/12] dyndbg: add processing of T(race) flag argument
To:     jim.cromie@gmail.com, Jason Baron <jbaron@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 4 lis 2023 o 04:06 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.=
com> wrote:
> >
> > Add processing of argument provided to T(race) flag.
> > The argument value determines destination of debug logs:
> >
> > 0 - debug logs will be written to prdbg and devdbg trace events
> > [1..255] - debug logs will be written to trace instance
> >
> > A user can provide trace destination by folowing T flag with
> > ":" and trace destination value in range [0..255], for example:
> >
> > echo "module thunderbolt =3DpT:7" > /sys/kernel/debug/dynamic_debug/con=
trol
> > echo "module thunderbolt =3DlT:7,p" > /sys/kernel/debug/dynamic_debug/c=
ontrol
> >
> > When T flag with argument is followed by other flags then the next flag=
 has
> > to be preceded with ",".
> >
>
> the trailing , seems punctuation heavy.
> Could we just stipulate that any :string  (leading : trailing anything)
> be the last flag in the spec ?
> bare T flags are not constrained otherwise.
> seems fine as API-spec-by-error-codes.
>

I followed Jason's suggestion to use "," when T flag is not the last
flag and destination is explicitly provided for the T flag, like in
the example above
"echo "module thunderbolt =3DlT:7,p" > /sys/kernel/debug/dynamic_debug/cont=
rol".

With "," we can have the following cases:
- when T is the last flag then it doesn't need to be followed by ","
even if destination is explicitly provided, for example "lpT:7",
- when T is not the last flag and destination is explicitly provided
then "," has to be used before next flag, for example "lT:7,p",
- when T is not the last flag and destination is not explicitly
provided then "," is not required, for example "lTp",

Jim, Jason, would you please come to terms if we want to use "," or
just assume that T has to be the last flag in the spec ?

>
>
>
> > When no value is provided trace destination defaults to 0, for example:
> >
> > echo "module thunderbolt =3DT" > /sys/kernel/debug/dynamic_debug/contro=
l
> > echo "module thunderbolt =3DlTp" > /sys/kernel/debug/dynamic_debug/cont=
rol
>
> no colon after T means p is a flag, not a destination name

Yes, in this case p is a flag because when T is not followed
explicitly by destination then next character would be treated as
another flag.
