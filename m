Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3199C7CD832
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjJRJc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjJRJcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:32:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE06B1A5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:31:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so86320171fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697621482; x=1698226282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QjheaEjRfKcRJsWNr6c0V1v0c9oT2H9QVa83EftNSs=;
        b=PjYHVL2AFOut/224ptF8VtNEhfpwRNPub38kA2MBq82iokhJNwgbjxKQavrGzm3Kbl
         3TbF2YuoJd3z9nA9e+rbcVQkYasWjyasLgMGeFcAohD88eII9Dn2m+wVnMpucIa8wYKG
         TqiwrGqS6LID234R8f85HJH7fSE9K9ljkfj8UcNSilhFADfLfBrT3ai9pWef8EOQTgg7
         qWaoqF77zTZ3obd5SWs5SRDcTfX19wDmQODQ1nmNYpyUXoU/dKdGPmXh4TMKCWwLMM86
         wwetkyQG3ONW47iNfq5KRYUQtx9vJNd4e/3IA6WIvbaDLdFuki5XLp530LLeIy8FeyHF
         zyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697621482; x=1698226282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QjheaEjRfKcRJsWNr6c0V1v0c9oT2H9QVa83EftNSs=;
        b=ZQkf+MVOrgyFpAna5PB5XYUtZNgKzDaQ9c1IWknogVqcuYfJt5wi0W8M+cU1VvHs9P
         D60dUP8uLav1kwCJWfCrxNdcMpheXojWnOu44jTEw18bhbQPGx5j54g033Oe4RLng8dM
         cqid0FP1vC0eRBghHSuCeGbY+XLLTk0qrFXEnoL2bIaGDVXW5D2dHJiTKjHOdG/dIv3L
         mnai5PyQe3/PdRWOJVLnHfMOxKaUzWN5Gt3mPTq5pwJUC234qmrLAS0+nTrXPsy+uaPJ
         hE7tcAxKVhaLQwm1pKiXyK/v+mPqIOeYm8g30pIf+YnAUT0tvqfjBCY/QARdBXfxhjTu
         GHsw==
X-Gm-Message-State: AOJu0YwV2Zp21DZD5Q0OGDrPV464izqgWeJ2QvckQbO+ac34SdVIhsD2
        4bnYa05Ms61hJNoY7Mdrr6GI+A==
X-Google-Smtp-Source: AGHT+IFHc/k/rIU+sAYuQvOHqwFIxrnmxpoL8ylYokPeKwjOidRYHM5IwFIWSNd3wG8Wr8cIoMs15Q==
X-Received: by 2002:a2e:9c51:0:b0:2c0:d06:9e65 with SMTP id t17-20020a2e9c51000000b002c00d069e65mr3332079ljj.8.1697621482061;
        Wed, 18 Oct 2023 02:31:22 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b00401b242e2e6sm1171689wmq.47.2023.10.18.02.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:31:21 -0700 (PDT)
Date:   Wed, 18 Oct 2023 12:31:18 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Karolina Stolarek <karolina.stolarek@intel.com>
Cc:     Dorcas AnonoLitunya <anonolitunya@gmail.com>,
        outreachy@lists.linux.dev, julia.lawall@inria.fr,
        andi.shyti@linux.intel.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: sm750fb: Rename
 display_control_adjust_sm750LE
Message-ID: <d219a6b7-0b59-4894-a0c3-01e286f6a132@kadam.mountain>
References: <20231018080416.25931-2-anonolitunya@gmail.com>
 <870b9b74-75bc-2a0d-7138-ae8df237f980@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <870b9b74-75bc-2a0d-7138-ae8df237f980@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:12:19AM +0200, Karolina Stolarek wrote:
> On 18.10.2023 10:04, Dorcas AnonoLitunya wrote:
> > Rename function display_control_adjust_sm750LE to
> > display_control_adjust_sm750le. This further enforces snakecase naming
> > convention for consistent naming style throughout entire file.
> > 
> > This change was suggested by Andi Shyti <andi.shyti@linux.intel.com>
> 
> You can use Suggested-by tag here, if you wish (as per [1]) before
> Signed-off-by line.

Yeah

> 
> In the first line of the commit, "Staging" should be lowercase.

There isn't really a rule on this.  People do it either way.  But, sure,
in this directory it's a 404 lower case vs 51 upper case so better to
follow the majority opinion.

In outreachy people are way more strict about some process issues than
we would be in real life.  And that's fine, because it's an educational
process.  I just worry that there is a certain amount of bleed over
where people start "correcting" people who haven't signed up to be in
outreachy.

regards,
dan carpenter

