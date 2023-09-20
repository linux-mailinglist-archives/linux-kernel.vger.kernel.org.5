Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7E67A74EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjITHyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjITHyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:54:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E0497;
        Wed, 20 Sep 2023 00:54:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c1c66876aso828389566b.2;
        Wed, 20 Sep 2023 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695196446; x=1695801246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3tL4tX8rYfsS08Kbw29UxKC1UcVvyu0MtL7bWeL0VBQ=;
        b=FzeJyqEVkWmix0m0sJIN2Hay/QetZ1udNS8HLaKkA1GNvg1YVwZaDsxsCopuEh8fij
         IEG8HCo5i4DJqdAk/CDuco/xtekRMfz1i6i9HJI70m6f0CvzPPVe5PmsZ67/7wEl2/xK
         6bx9trP6w02Dzt6BHPZ8NGYwrkKLsq06LGZYy9omfP8/6+tk54LUmGolEp/Zl9E/KpNS
         l+DlpKfIpE6REl7mTTHN5rJzOBBOi69hYyRLAro6atRDnxXo26kGW/e7srezT3jOE3D/
         tlAJyn4TMhfaLlvWtTwBnw4g+aUIi7tRlX3ODAA6RXMtA0A9BzUleYQMiaxsNoiF63Oz
         Dksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695196446; x=1695801246;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tL4tX8rYfsS08Kbw29UxKC1UcVvyu0MtL7bWeL0VBQ=;
        b=mwGUX/YdTSEdjH4Q5stBEuNvXjL467yhQOqZC/2wYmrJD2Km+kW28cgYcvniJC/2Hk
         0f4Nj/xWInEC5imPAcecBMBi64NfB4mCpHpdi/XVPegD0uTvKzBB+65BSN4hN+3dJtW7
         CRzLip95ej+W8afZgHRKvkOaPBEJR9d4+3L/25BIomjnjpXiXCIKGd+2aYAM8PPK2EPd
         EQ07/jFNRLiQ6yj7IS6WxAzQB8LilASOpdzVRmOccf7Q1j1Njqhs0PSsVXzygL/oZeN1
         ibBq0+NDIiSvqLS45Lgb3ZmXLV5S1b/CaS0p46BxTtonahzds82c9EbunqqmCh8z5YmG
         W9mw==
X-Gm-Message-State: AOJu0YyVquAnwFB31SxGjBkGPOUOuRM47KKdTKF5vy46etRPp6aJHk6a
        E96PPiG1NaKZadyGpGyoyp88B/XkJBa7SBSk
X-Google-Smtp-Source: AGHT+IGFYrSyFSJgXcKtPSHqP8piQSTkFKdmgxyXsmFpEcWzpj5hHIeoNYMabRrcfFqVQ2/+KuGP0w==
X-Received: by 2002:a17:906:1054:b0:9ae:4843:66ee with SMTP id j20-20020a170906105400b009ae484366eemr998434ejj.36.1695196445776;
        Wed, 20 Sep 2023 00:54:05 -0700 (PDT)
Received: from [10.0.1.99] (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id x8-20020a1709065ac800b0099bccb03eadsm8833415ejs.205.2023.09.20.00.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 00:54:05 -0700 (PDT)
From:   Emanuele Ghidoli <ghidoliemanuele@gmail.com>
X-Google-Original-From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Message-ID: <91e05b62-e0f9-65bc-2ceb-6b45a9028588@toradex.com>
Date:   Wed, 20 Sep 2023 09:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/2] Input: ilitek_ts_i2c - Fix spurious input events
Content-Language: en-US
To:     Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Joe Hung <joe_hung@ilitek.com>
References: <20230920074650.922292-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20230920074650.922292-1-ghidoliemanuele@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 09:46, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> A couple of fixes to prevent spurious events when the data buffer is not the expected one.
> 
> Emanuele Ghidoli (2):
>   Input: ilitek_ts_i2c - avoid wrong input subsystem sync
>   Input: ilitek_ts_i2c - add report id message validation

I did a small mistake, V1 never existed, this series will start from V2, apologize about that ...

Emanuele
