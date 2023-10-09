Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AACC7BEE09
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378872AbjJIWE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378870AbjJIWEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:04:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F71FE1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:04:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-277564f049dso2937692a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696889086; x=1697493886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMGseJH3xVpjS3Dz1XvWa31fmlgKwg7+vZGsOfoEaiI=;
        b=EOMd29C/7PuKYL5m4fkQywhldbZ76H6cZ/Wp35HIHUM9CPVzHk+9CRR8ZRQ8OH2f/a
         z53yE489POmJJmfPNHJcyDLYBudpVrti6QUbsWHd5sl+rqrEamhfVdY9bme8J89TvunX
         g/olBL8ln0Q1S2bMDXaSBlMYKX05wEyOdEDPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696889086; x=1697493886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMGseJH3xVpjS3Dz1XvWa31fmlgKwg7+vZGsOfoEaiI=;
        b=nnhlzKjAT6JziWJmrnWFbp2cFF0Fs5MmuAkxWPTkKXww8tikU4T8+ppylaextUN/VM
         EGCIImktUp7cjC7GFz3XFQo7U7u2h7BCs8sK93q2kmfH3KBndCWAthmPXrNC7Ty+70/z
         nmsxJ4RfB1M2Ma04MiQ+DVLEzJOb+ldJRE620AhdkFQ9lCycORYYBXr8GJK7wHFKmnhs
         A7YktD3WctDkW6aMtvZ2TCWIdHyfuBrKKA6w7vgHhdP31O5TI0Ry14lRUvIiV3upbFNO
         czqjlCX6nfqa1lrrMRsobrKGUDvVyofllJ84V5aARqrMvY3/GPRdP0OZBGiTAtMdJseC
         io8Q==
X-Gm-Message-State: AOJu0YyF/VmRgCpzG2F3zleiwGv5tIBHEZ83Sj9CRsrcR8hIcAxbuhah
        TqLVwbzZLXxCpH1ELe3YSOugyw==
X-Google-Smtp-Source: AGHT+IFwi/Hx77Qov3jXx2LoubrzaSvq6vp4/lVzgPmZBiOZdmu2RVJwmuDRCsMOZxlgxrP9y1bTLA==
X-Received: by 2002:a17:90a:9205:b0:267:f5d1:1dd3 with SMTP id m5-20020a17090a920500b00267f5d11dd3mr13172366pjo.11.1696889085748;
        Mon, 09 Oct 2023 15:04:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001bf6ea340b3sm10155489plf.116.2023.10.09.15.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 15:04:45 -0700 (PDT)
Date:   Mon, 9 Oct 2023 15:04:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] soc: qcom: apr: Add __counted_by for struct
 apr_rx_buf and use struct_size()
Message-ID: <202310091504.0C46189372@keescook>
References: <ZSRw6RNi3Crhd32H@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRw6RNi3Crhd32H@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 03:30:17PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Yup, looks right.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
