Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2D7C4C04
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344944AbjJKHgp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 03:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343574AbjJKHgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:36:43 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EC79C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:36:40 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-694f3444f94so5453500b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697009799; x=1697614599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaEUcjc9uuJSpeIxbEI/eEl/LVy1WFrSHwf0useJCr0=;
        b=VgKwQVoQZ7cU33ocAiF6TLpiTcR61bAmpMI4o6ETRH0chRlddqTHb6h1KQ5FRw8Rw0
         gQVFbPXrnLyD8LlepGGYEjzBLZhLIOuF85FKIMVy6QgMM4mzeh8f2mB+5XVmui2loRrF
         WjZV7z/87XRXBb5f4+QoZY3Q69p++4vbu7XxV3/HHL3ebuu8d5u4yCf1DRSGGajkj5DE
         HWsdcLX3ZhHWFy0NAjlqrsuCd8uUxf3gQplAB7IAm8Zbk8EdJoXCYK7SLrpvAVa9moJC
         vpLaLwjKdESqAxXnvUMfyzfp5qlmRJg50zaF2wVJgcizhPqIgUmTewaUEbSq7PLTIFRx
         ttGg==
X-Gm-Message-State: AOJu0Yx9+Ow+o94mwgD09g8k3tgSLDj2D18zJglHOCXlpH7jme140Hky
        3T2skSwWQ09pW1+iqtHT5kqL0ufWF/tJ1kh0takrKEg5
X-Google-Smtp-Source: AGHT+IH7DNwyqNlpspYEPvpjSOc298VkOMNnhkRXC7u7Z6JCno8//szn/xuy9YhhMaFh/PeUskLtUgrZ9smWHSnhZfI=
X-Received: by 2002:a05:6a20:1447:b0:14e:3daf:fdb9 with SMTP id
 a7-20020a056a20144700b0014e3daffdb9mr25776243pzi.22.1697009799490; Wed, 11
 Oct 2023 00:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com>
In-Reply-To: <20230601075333.14021-1-ihuguet@redhat.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 11 Oct 2023 16:36:27 +0900
Message-ID: <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Cc:     ojeda@kernel.org, danny@kdrag0n.dev, masahiroy@kernel.org,
        jgg@nvidia.com, mic@digikod.net, linux-kernel@vger.kernel.org,
        corbet@lwn.net, joe@perches.com, linux@rasmusvillemoes.dk,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu. 1 June 2023 at 16:53, Íñigo Huguet <ihuguet@redhat.com> wrote:
> EditorConfig is a specification to define the most basic code formatting
> stuff, and it's supported by many editors and IDEs, either directly or
> via plugins, including VSCode/VSCodium, Vim, emacs and more.
>
> It allows to define formatting style related to indentation, charset,
> end of lines and trailing whitespaces. It also allows to apply different
> formats for different files based on wildcards, so for example it is
> possible to apply different configs to *.{c,h}, *.py and *.rs.
>
> In linux project, defining a .editorconfig might help to those people
> that work on different projects with different indentation styles, so
> they cannot define a global style. Now they will directly see the
> correct indentation on every fresh clone of the project.
>
> See https://editorconfig.org
>
> Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
> ---

Is there any news for this patch? I would really love this to become mainstream.
