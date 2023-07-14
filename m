Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A4A754082
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbjGNRfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbjGNRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:35:06 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1CD113
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:35:04 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-791b8525b59so780253241.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689356103; x=1691948103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OV2Ug93Gav+8T58ju3y8+5YHTN9dRtivqYz5Rn6HN1A=;
        b=Sm9T+5FUWy9zTWEzVG78o87Iy6UsmlLRmNJgtucTulyYns58ZoWCv8w970rl1/Veyk
         pQ4NLkLFyNSd13q3i3b45TJraXrG9xSh4AjYUF10lBciIC0w+xExyhuyeBXs+6fxG/vo
         hA3bB7vFfEQXnyPAT5lqs1JvkIHQhxS3aGw61j59s3DkT9E4BwGeZksq99GQ7reN7UH/
         0Ah30FOruU1Nll2XF+a8TGNd1gxd043C00oaHodwCqdDUqYB8ygGI5J3wLNW85t+ZfoF
         yl0PNvQhLOjs3oIeysJjAamBdZm04eyfNwI3ESXzlXRzPT/gVBriJqYVRjq31guxDrxf
         Wvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356103; x=1691948103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OV2Ug93Gav+8T58ju3y8+5YHTN9dRtivqYz5Rn6HN1A=;
        b=UFwijuswx8CyKd1JF2/5+h0+eXSmV0zIoqclgANH/CxfL9utOXmAIlOVX5bZ7SQCIz
         Qj8JnUCNOsqDAloUy55LByD+oixbi9yfR8+lFbrsGb90XLnxsEhY6aQh1hc3MIQfIUC8
         McaYfL+Qgwm1xtDFnx2c3dFdPpjMddZaNgqgz24yzorz0f7ETelkCdm0pxtvCxb2NbKM
         PvnlUe4DVO9KFO2/aSFvG2Ms1iggat4yqqwRWDEyiLF4xIPiPAJOpgiUhKBEx1ONuXvD
         HBMLksjhIPc6VVNsOdhRSn1AN89bXGmOf5Fn9lYQMOMk5WwT3kQAquOlCZco3Nfzggr1
         tQ0A==
X-Gm-Message-State: ABy/qLaYkV21xctaVsEX94eV5ygLxUhdnAtXDeAxyuUY2LhL91qfmeDn
        DE9Fpq3BNN84BW1PM1LyUe23zbvKBWC4pC7go7g=
X-Google-Smtp-Source: APBJJlHPWnkuzIUxdR+EPWCIw+Tcbf5bVSlQ7Yephhjpo0reZQAZ9ifJDHW1WXS2A1nan9Wfq45XF7N2gMqGphOO4CM=
X-Received: by 2002:a67:f1c7:0:b0:443:895d:1b53 with SMTP id
 v7-20020a67f1c7000000b00443895d1b53mr3445086vsm.10.1689356103255; Fri, 14 Jul
 2023 10:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230713163626.31338-1-jim.cromie@gmail.com> <20230713163626.31338-22-jim.cromie@gmail.com>
 <76995421-a529-ac25-c306-2e4ac2844602@infradead.org>
In-Reply-To: <76995421-a529-ac25-c306-2e4ac2844602@infradead.org>
From:   jim.cromie@gmail.com
Date:   Fri, 14 Jul 2023 11:34:37 -0600
Message-ID: <CAJfuBxyUoVJU13cVxtp01PLfQ1v3PZVWD9vLLR1y+Fiz5Xd66A@mail.gmail.com>
Subject: Re: [PATCH v4 21/21] dyndbg-doc: add classmap info to howto
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 1:13=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 7/13/23 09:36, Jim Cromie wrote:
> > Add some basic info on classmap usage and api
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  .../admin-guide/dynamic-debug-howto.rst       | 64 ++++++++++++++++++-
> >  1 file changed, 63 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Docume=
ntation/admin-guide/dynamic-debug-howto.rst
> > index 8dc668cc1216..878750ce8c1d 100644
> > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
>
> > @@ -374,3 +373,66 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``=
.
> >  For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format stri=
ng is
> >  its ``prefix_str`` argument, if it is constant string; or ``hexdump``
> >  in case ``prefix_str`` is built dynamically.
> > +
> > +Dynamic Debug classmaps
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Dyndbg generally selects *prdbg* callsites using structural info:
> > +module, file, function, line.  Using classmaps, user modules can
> > +organize/select pr_debug()s as they like.
> > +
> > +- classes coordinates/spans multiple modules
> > +- complements the mod,file,func attrs
> > +- keeps pr_debug's 0-off-cost JUMP_LABEL goodness
> > +- isolates from other class'd and un-class'd pr_debugs()
> > +  (one doesnt mix 2 clients bank accounts)
>
>           doesn't
>


thanks Randy,
got this, and the rest.
