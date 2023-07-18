Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CA175834A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjGRRPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjGRRPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:15:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E874BE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:15:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31441bc0092so5779861f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689700515; x=1692292515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0b3Vly9emv1HHVlSd38yfh5xQjrqeAe6ysyE2is2jXc=;
        b=h6TLwmWojjpbLukjXrGCuGV+GJT1TT3eflwtZw1JiAa8EaHDFqvztGhW2rOBTnNuYv
         pJscema2DoTzIZ6SqIAO8pYwN2bRJcM1GZf5/HRPmAIzCi3SH+MgPq6WJGz+F0YTm5ix
         1/M1QprNID/sFMmGTw/BEC/Huj4dB9DHCtirago5WfUCu8GzDP8V2kVYQQvoOcleMNvn
         ILP8m76TXAt9fIYrQRxuDfpmcqKKDDnlc/xLTClVyED91NVQg62cGrT6aPhPaa/fVrQv
         Z4/Jc8sShTdbV+3YJmQPb6bdgc9DzTqHk3mInaue1i11gaAOCvI4aHXRm3Kc/SiqVfz1
         oyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689700515; x=1692292515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0b3Vly9emv1HHVlSd38yfh5xQjrqeAe6ysyE2is2jXc=;
        b=lzQavSG6mGaeIhJlo/NhhesdHSt//oUi4IFzBYlDyszBy5oMCllfZf2tsJI0Hpl5Xl
         Fz26boBZD/bp8YlnIvAgXtffPuru3lClsoAlb+rfB3qXAAS8ojHJO67NwK+ysFzn60DX
         cLse5FzaA+/abkpZfAQK4l7Ekz9CQfTAH9CI/cnbywMLekvTKRV1WjPk6+hRkkr+yzpQ
         LUw0ugprHgngimGnHeb954gu7j3bBm46UJqNz+niID2DK4H92mhzgRonL3fwePzcso1j
         SaTAr2jRJKjEKiex/08zJyyFEOY0HwX7ZeGT4YDFlQd6IHuCvGRMjS3QCGOQE7rU3HbP
         mNAg==
X-Gm-Message-State: ABy/qLaZpvs7kjIKJ+r/yT2LtNBGUsBzL7biI35s032BnkN2Byb6mare
        X1GAGjouAdq7b9W+rVMIt/65jvMwpZqMnjqHt/k=
X-Google-Smtp-Source: APBJJlGFqBHV5lb5GSyERvL4mSEEBnqLmVmrcoJt9riZbVC8qBpdqlZlileeT2GgK6ldh6XYCRHibw==
X-Received: by 2002:a5d:452d:0:b0:315:ad03:a9e0 with SMTP id j13-20020a5d452d000000b00315ad03a9e0mr12487178wra.45.1689700514894;
        Tue, 18 Jul 2023 10:15:14 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id n8-20020adff088000000b00301a351a8d6sm2937641wro.84.2023.07.18.10.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 10:15:14 -0700 (PDT)
Message-ID: <4e6c4534-896b-8b35-b4c1-dd1359d6f8a1@linaro.org>
Date:   Tue, 18 Jul 2023 18:15:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Add support for XMC
 XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
Content-Language: en-US
To:     SSunk <ssunkkan@gmail.com>, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230718145132.3811-1-ssunkkan@gmail.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230718145132.3811-1-ssunkkan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/23 15:51, SSunk wrote:
> Add support for XMC XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C and do not use the generic spi nor driver.

Why can't you use the generic SPI NOR driver?
