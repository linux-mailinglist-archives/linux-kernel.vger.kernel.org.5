Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE877BE8D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHNQ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjHNQ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:58:41 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECC11BF1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:58:22 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40c72caec5cso11281cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692032302; x=1692637102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/WoweT55sLO5fRn6kufHuPlBBPxo8HUXjSRuA4Mczg=;
        b=Q0fc8BLqD7wyXCOAOk3IPDV9Cp5h/LQhx8w5FeDc/Oq4xCCNjGiU5lj7eVG2UDAi6G
         gGKMMSEj7LdqNHelfpKXokpTmkEFBPK6JYd8ld6zO95MjKEBiP6fI8HxhvZrtBzgcmlR
         cugbBFjd5mmw+vkHfF9Cm9YLJ67TZrAHPcKCcqrOKlonZr3F12NeFub35TIFi/dEdUzu
         FNpHd4c4rMjTr4IK7AohAigfWCtG8EEekRBSyf7hUiUQzQ56cgtAZIOj0lS+Ne46ZzAn
         UXrIAr2vFref6NqwfEAmWNR/V498cbQ97SQq1LESFt1XuCEnzpFOHNjIO9u4Ve6lkj6A
         1tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032302; x=1692637102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/WoweT55sLO5fRn6kufHuPlBBPxo8HUXjSRuA4Mczg=;
        b=j/Ys/DRG69xo2yoMBsmkwps6Jwsblq9xdzA1rh+v1sOV/c7/xkmQP+RU+n2+JzpEu1
         uCEcYWtihfbbNhS/MVYy/00bWUOJGXaMa9drh48IxGYCPR2zmBFgOPk5HL6rFVOcEkRi
         egofu1aP/62nDk5Dd214LjxwrMxPKc5NREx79MblAUFz2LwXzAqQNPXENXXS+6VQr2g7
         y396nnOdGVSEONpvT9DpsATUyDfS0mfeSFflHO0K1FFfLghigK+87NAPTz49Wla08fPF
         QuyXjxNJApp+waBt4A7ZJXd2G/6OrLXGytqnuqrs42L+FZxWmYu5RezsUMlF1LC+KudK
         cB1Q==
X-Gm-Message-State: AOJu0Ywdcjk9ouXMC8TO2zqWYgO3SZOb4u7rSXR7LOMP593Qv35avO97
        p5BYi2xcnd+Ojx1+BpvteqD+NH9/RZwqtZyuBhog8Q==
X-Google-Smtp-Source: AGHT+IH+ZEsxASbuHJbtYOaL4jiCGRwyq9SBYfbwVUTjbFILjWP+xu+p/05rzPYZrbX5Rmv6vLcEDwCgX13wDicyzFU=
X-Received: by 2002:ac8:4e55:0:b0:40f:ec54:973 with SMTP id
 e21-20020ac84e55000000b0040fec540973mr684272qtw.22.1692032301951; Mon, 14 Aug
 2023 09:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199900677.1782217.12516417657696965559.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169199900677.1782217.12516417657696965559.stgit@dwillia2-xfh.jf.intel.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 14 Aug 2023 09:58:10 -0700
Message-ID: <CAAH4kHbRkFdmdQyPHjOjnnyuYXPLT2GKmQTE8fU9aDFMtri8ew@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] virt: sevguest: Prep for kernel internal {get, get_ext}_report()
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

>
>         switch (ioctl) {
>         case SNP_GET_REPORT:
> -               ret = get_report(snp_dev, &input);
> +               ret = get_report(snp_dev, &input, SNP_UARG);
>                 break;
>         case SNP_GET_DERIVED_KEY:
>                 ret = get_derived_key(snp_dev, &input);
>                 break;

Do we have an agreement around the continued existence of sev-guest
for supporting derived keys, is that similarly slated for the chopping
block, or is it left undecided?
It appears your choice to not include the uarg/karg extension here is
deliberate.

>         case SNP_GET_EXT_REPORT:
> -               ret = get_ext_report(snp_dev, &input);
> +               ret = get_ext_report(snp_dev, &input, SNP_UARG);
>                 break;
>         default:
>                 break;
>

Reviewed-by: Dionna Glaze <dionnaglaze@google.com>

-- 
-Dionna Glaze, PhD (she/her)
