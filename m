Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221A0782412
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjHUG5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjHUG5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:57:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FE1B1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:57:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso389033466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692601033; x=1693205833;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcUST9SZiLfr9X1fVF/lhK99tBClYRjItpkjDoIilrQ=;
        b=wy2C8SHGuYf3WfuX009mdzZ5XZKXm6x5wMJpS4OiokkuziP4cqnZdG+fHzQ2QU5akQ
         WBx+QVHhzUKtcyMWCgKqeH+Lregd2W9LER2JfbaSHFRgTodkPg3vqhpnh30OkuVoiQJV
         +PrBrZE7Bc8LC37QHBohIp452Sw5E9AJqeDNieWfb5DhnjTqMuKWYGClzsNBNS+74GrP
         AW9S0TO6MGEG9Fw2tcCoYb2baNT7C6y3wMkxVf3fg+6MS5sieGbVOH/cYYnYrqyr2pRR
         pPIG+EztF4fvGvIlY+fq4c8xGNL3nvNN28q3wxwd3NKv6L8VhlYAxY8uXmsSGXAyV78u
         rvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692601033; x=1693205833;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcUST9SZiLfr9X1fVF/lhK99tBClYRjItpkjDoIilrQ=;
        b=cwthZpw4FSirxfPhoP5V8ojgWwYfSVa8EQ2nTF9ze/kDmTJE3CwoQLL9mFymJHpX7N
         rXDev9ESi2kivkuzJp5+NKghtGDOCd0vjSPesrgB59rF+UBMjQS5K5FD3S8dWtibLR6e
         LKVLT2C/P63kvze4hS2+k/GqjMhZEJFtI4QGyO/DFvR7WnZvjl8pSGWIbTDgRI48eG40
         M9NzZSZht+kq74O8Qfl45htqnX+5hDdcv26TAkzZXET8Xq20p7dUfaeOe1LWak4Nrqx/
         wSI8VLLlDdRkg8zs1QUvC/T/icmDc6ITBjQFvVHheVz+TJmFEgMccfdhHtVIO0tqkE5a
         98cQ==
X-Gm-Message-State: AOJu0YxsHXV2fsA63DeZzEGkCiA434aXmn3i98peScphLssWTeRD3LZt
        DtkMCYSNsQMW4T/HtNF9niixgD+jUe9xNaVuw7s=
X-Google-Smtp-Source: AGHT+IFUiUHh7317bQXeLITJXa9V8OWztbob/uSWKTijDJIT0Ls0uhKEVMBmxWVIjxt06llzNnnQRQ==
X-Received: by 2002:a17:906:209c:b0:99e:f3b:2f7d with SMTP id 28-20020a170906209c00b0099e0f3b2f7dmr4999921ejq.74.1692601032834;
        Sun, 20 Aug 2023 23:57:12 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id m11-20020a170906160b00b00992f81122e1sm6073850ejd.21.2023.08.20.23.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 23:57:12 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20230816130057.28717-1-quic_kbajaj@quicinc.com>
References: <20230816130057.28717-1-quic_kbajaj@quicinc.com>
Subject: Re: [PATCH] nvmem: sec-qfprom: Remove unused variable 'ret'
Message-Id: <169260103196.7216.15564466275943552417.b4-ty@linaro.org>
Date:   Mon, 21 Aug 2023 07:57:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Aug 2023 18:30:57 +0530, Komal Bajaj wrote:
> This fixes:
> drivers/nvmem/sec-qfprom.c:59:13: warning: unused variable 'ret' [-Wunused-variable]
> 
> 

Applied, thanks!

[1/1] nvmem: sec-qfprom: Remove unused variable 'ret'
      commit: 2b30c8e6c9ac18d57a6afa09cb95d5d2cb28ba5f

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

