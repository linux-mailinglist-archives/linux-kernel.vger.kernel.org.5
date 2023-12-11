Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C1980DABF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344597AbjLKTVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344349AbjLKTVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:21:43 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B2FBD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:21:47 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4258e0a0dc1so28812331cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profusion.mobi; s=google; t=1702322507; x=1702927307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+q3XVK2i6i8i/tjsGLnz+6VEGZ+iQwH0e6JsQ2ll1sM=;
        b=Zc9cWKgnpgTasLeSYbIzVrJOFJCb9Mu1DiRtrfyj3VOI5ZC+dttClG2fLN2ZB5Mh9D
         8Ae8yMeM5D5KPUZqY1WD1I9LIPFouqDeIk08AtIr/qILKuO+CzVTWqLvapPiMMRLPHdv
         DlTpIUnVUjPOsEgV7xJThkZNad4nkBcraqNvSP0N5xpn8Jp8+H1pAa+gKo5/UfIn7QmV
         FNbTpRxJWlbzrHPWzd2SZQJmWdXkBZFjYhPkkw0yCB5HuUJHXu0tI+ArPM+g0UOfmayB
         F2g/+L5BXENNrzTolp+uQt3MtlEwCNGXnO0awJW0ym4IZOeItjrb5g7Jc+IuGgCIEL4q
         W5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702322507; x=1702927307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+q3XVK2i6i8i/tjsGLnz+6VEGZ+iQwH0e6JsQ2ll1sM=;
        b=QnLVGQRVItFeDOtxJUzT72GKRMwCxznc8o0oqz3PjJR/czk9bw/1pGpHqvpF/0W7Jh
         woL8Z1D090t7+9scDPsSVLgzKUgfDvBFH7qhUqld0afD9VbXjzMgWryzCPEwej9iC8b4
         MsJg09u2sd21hxJ6qzZfoQhNkf3cWILliku7/f0MxP+yvLKZivSHuRjIbWxKBs9I0QrL
         LcjbJvd8/afdGCu3CTkQgU6ENTXiqI9stTnFo3d+l8YYMmhfhGfKkwdBbbxjroXu3642
         C6N+h07ZmXLXV62vdD3MKPPU2oF5LiTLjB79HPxLptYchVo+P2giY9r6KPCPhh7VNjl+
         8Muw==
X-Gm-Message-State: AOJu0YxMNd+E2Nma/zJbE6R69+XatO1zCsrZokip/0dJS1P8oRpGWtpS
        GItw8OTZ+sx1Av8vHMctmMFdxqRgOiqeer/68HVWLg==
X-Google-Smtp-Source: AGHT+IEcvhBhDFbIc8qohR/ciuBi295P5AkeYB2ByIm3POtNdTKXzF/65y2z3RoKGb0Mlsg5F20kQGLflz4nMRZdc0I=
X-Received: by 2002:ac8:5fce:0:b0:423:77aa:163b with SMTP id
 k14-20020ac85fce000000b0042377aa163bmr7007200qta.51.1702322506786; Mon, 11
 Dec 2023 11:21:46 -0800 (PST)
MIME-Version: 1.0
References: <5d48c1fa-d577-6f4c-5d3c-37884053e1a9@collabora.com>
In-Reply-To: <5d48c1fa-d577-6f4c-5d3c-37884053e1a9@collabora.com>
From:   Ricardo Dourado <ricardo.dourado@profusion.mobi>
Date:   Mon, 11 Dec 2023 16:21:35 -0300
Message-ID: <CAHrXaCvAf=bB-mHix4ai_J3vkzMmzm37QzdPgPzKx8gs2GLtQg@mail.gmail.com>
Subject: Re: KernelCI is designing a new Web Dashboard: we want your feedback!
To:     Gustavo Padovan <gustavo.padovan@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
        "automated-testing@lists.yoctoproject.org" 
        <automated-testing@lists.yoctoproject.org>,
        "kernelci-webdashboard@groups.io" <kernelci-webdashboard@groups.io>,
        =?UTF-8?Q?Jo=C3=A3o_Bertacchi?= <joaobertacchi@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_GREY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi community members,

We value your input! Please take a moment to share your thoughts on
the KernelCI Web Dashboard through our quick survey:
https://www.surveymonkey.com/r/PHG2BC5

This is going to take only 5 minutes.

Your feedback is crucial in enhancing the KernelCI Web dashboard's
user experience, saving time, and increasing productivity. We
appreciate your time and contribution.

Best,


On Tue, Dec 5, 2023 at 8:38=E2=80=AFPM Gustavo Padovan
<gustavo.padovan@collabora.com> wrote:
>
> Hello,
>
> TL;DR: KernelCI engaged with an UX speacialist vendor to design a new
> web dashboard to show our test results data. If you want to give your
> feedback, let us know. We still have a few spots for UX interviews!
>
>
> As we shared previously, we are in the process of designing a new Web
> Dashboard for KernelCI. As you may know, at same time, we are putting
> together a new core infra to replace our legacy and limited system.
>
> Ultimately, we will have a CI pipeline that allows tests to be run not
> only in KernelCI labs but outside of it too, but with test results
> contributed back to the already available common database. Then on top
> that, we want to have a powerful dashboard to help the community
> evaluate the test results in the best manner possible.
>
> You can read our blog post for a quick summary of the UX redesign
> project: https://kernelci.org/blog/posts/2023/ux-analysis/
>
> We have just started the first phase with the UX team interviewing
> kernel maintainers and other users of KernelCI.
>
> If you are interested in providing your feedback just reply to this
> email or reach out to me directly. We will try to accommodate everyone
> that is interested.
>
> Regards,
>
> - Gus (as Project Manager for the KernelCI project)
>
> --
> Gustavo Padovan
> Kernel Lead
>
> Collabora Ltd.
> Platinum Building, St John's Innovation Park
> Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718
>

--=20
Ricardo Gej=C3=A3o

Senior User Experience Designer for KernelCI Web Dashboard
