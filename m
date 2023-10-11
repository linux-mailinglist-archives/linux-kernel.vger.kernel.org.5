Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B847C602F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjJKWLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjJKWLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:11:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3CE91
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:11:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b974955474so47438566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697062276; x=1697667076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhgX/dT2gCuxMHIWEQOv1K3rg0gvaqZCxPoncwnsvVo=;
        b=j4M1PbkQ0UOSountyN9EKVqH0mP8BPzIDSm7kihrrEkepJQ7331bZ/lTCh5XBPpVHl
         pXZumO51/O3i+DPP0yP8/U4f3dZ1POQcTy1tfnDPA9Tr0S602luIaEHt436vb4SPr8P3
         NcVyDt2stwBpbRuN8MpXLj5zIQpzDap7ENEgx9JyAXzn4ylXRzWcTVJx5k05N0Q9HkRo
         iRuE6U7+Yd467Julc2wdPS4jMpEtrBnDhnTceVEc9Ukus+yORuFzxdTaGRFB1sP9COxN
         qxBpQIv/xAIKOxSn6nrzT+7H83LOgSdZu2PfbMiYx7ASsJaVWC69Yuhcu+VoagVFCAw1
         wM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697062276; x=1697667076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhgX/dT2gCuxMHIWEQOv1K3rg0gvaqZCxPoncwnsvVo=;
        b=XDCHa6QTcmqz984nIBRt5DJEd49YnE6d9xgsLX18Yts/7ryD034A/5ZMuO+gKLYl4d
         E8b7xygQF3qHd2Ejwo13b+6w3I14U7AMNVAtv7t0VOl2IRAKWYGDlJyt0E5SFDBUpRXw
         ZqzWL5opepFmyxm2UAwReJRMvGKrhqk/1Fz0kkWe6zEDAbNQ4hZfFX+SfED6LWoMfAeQ
         IDDDIxMLdNyUFZmSfgJU7L/1USuAtCdaMTSDeAxx7kZi2qpM6xtE0kkhl76JnsAa4zz1
         pNXnRjGR92TtdksowWHSQ9l+i7bNJWueOs7nDOeVLtxar7k0AqW9apert/IEKdqjvEyT
         llWQ==
X-Gm-Message-State: AOJu0Ywj/Y4YWHXQImbotWrG5BXAx8sYzZtXtOrUumIhgav8DbRC50wO
        2ufG+ZRZWfxQAecxowidLpIOtWe+Vz0=
X-Google-Smtp-Source: AGHT+IFdVw3W9JDzDARpTURRuRL9RENoEkG8ethbf3dk4nmTu0DDj6BRS+g79rJzjtPL7dy/RsIl0g==
X-Received: by 2002:a17:906:23e1:b0:9ae:53a2:4289 with SMTP id j1-20020a17090623e100b009ae53a24289mr21106487ejg.63.1697062276084;
        Wed, 11 Oct 2023 15:11:16 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906710b00b0099bccb03eadsm10227283ejj.205.2023.10.11.15.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:11:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Oct 2023 00:11:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Lucy Mielke <lucymielke@icloud.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: fix format-truncation compiler-warning
Message-ID: <ZScdgaVra/PHRRc/@gmail.com>
References: <ZSb0B+9otHhd8jCp@fedora.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSb0B+9otHhd8jCp@fedora.fritz.box>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Lucy Mielke <lucymielke@icloud.com> wrote:

> Compiler: gcc x86_64 v13.2.1
> Config: allyesconfig, "treat warnings as errors" unset
> 
> This fixes a warning emitted by gcc, stating the output may be
> truncated. The fix included increasing the buffer size to the one
> denoted by gcc.

Mind including the output by GCC in the changelog?

>  static void seq_time(struct seq_file *m, s64 time)
>  {
> -	char num[15];
> +	char num[22];
>  
>  	snprint_time(num, sizeof(num), time);
>  	seq_printf(m, " %14s", num);

Fun.

So this:

static void snprint_time(char *buf, size_t bufsiz, s64 nr)
{
        s64 div;
        s32 rem;

        nr += 5; /* for display rounding */
        div = div_s64_rem(nr, 1000, &rem);
        snprintf(buf, bufsiz, "%lld.%02d", (long long)div, (int)rem/10);
}

... actually needs 21+1 bytes?

Which I suppose is true - longest s64 is "-9223372036854775808"-ish, which 
converted to the fixed-point float format above is "-9223372036854775.80": 
21 bytes, plus termination is another byte: 22.

Maybe put this into the changelog too, instead of relying on magic GCC 
calculations only. :-)

Thanks,

	Ingo
