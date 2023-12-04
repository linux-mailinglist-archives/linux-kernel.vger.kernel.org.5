Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33BA802E0E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjLDIsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjLDIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:48:13 -0500
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F76A4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:48:19 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50bfb930dbbso29379e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701679697; x=1702284497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=stuQAlSynF5gHOeTnXQr4VTnIhYqhEJP+qL/gtaT9Z4uZiq7P//+bu6XZQ6eXYMd9C
         6x6VPMiBTD7SdS+OPpkVKoB21eUiD3x1tXoQHsorocK9iNMt46sAwMrvt+X2T1QRx9G1
         QW3/A9lz9m6AOz6dVfo7ne4YFX/O42WLAbfQ6CfGEeVj+NdDRcIrxvpYi9tD179YN7PI
         wwPRtBuj8FUsmQk3Mr+UgF13f1LtJfWzXi9rgCQob4cM2B6nZqDGnV7gh9Y9J6HR/PTv
         oknyAkYtl6As8fALxYUTHPOY2xou5lmKhEVs037GeT33wVy+9nVrNuSX1WsMUAgwi35K
         VN8A==
X-Gm-Message-State: AOJu0YwZCoW/OIhbb/+Yrsh7wt1LDP/h9OBTU7bFFA+ZfpgOuIjmMPRP
        Yf1mmO5Qyo3xJXuRZ+EosPY=
X-Google-Smtp-Source: AGHT+IHo2vwdWW1D29AvtzuRbUja4YE5rhmSMUTlmHPKq97SUL+UoHsYjc2vQAYcspDiszlsqDRftQ==
X-Received: by 2002:a05:6512:3b8e:b0:509:b45:8879 with SMTP id g14-20020a0565123b8e00b005090b458879mr8618530lfv.3.1701679697440;
        Mon, 04 Dec 2023 00:48:17 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b0040836519dd9sm14146448wmo.25.2023.12.04.00.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 00:48:17 -0800 (PST)
Message-ID: <c4311f72-7beb-499e-90d2-2e136da45388@grimberg.me>
Date:   Mon, 4 Dec 2023 10:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 3/3] nvme: add csi, ms and nuse to sysfs
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231201092735.28592-1-dwagner@suse.de>
 <20231201092735.28592-4-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231201092735.28592-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
