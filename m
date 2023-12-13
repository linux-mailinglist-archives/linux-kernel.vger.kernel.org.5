Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D30B811ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442204AbjLMT06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjLMT04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:26:56 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CBB0;
        Wed, 13 Dec 2023 11:27:02 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28abca51775so1467053a91.1;
        Wed, 13 Dec 2023 11:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702495622; x=1703100422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWVW0olGcSxCBdJ2tMtPIREhrLezlbroagvUoCyknJo=;
        b=oWrCZS60H+zZMK6XgMok6XWpCcARVCjMpj7VrGqtyGQ8J5x1PyJMUM4JPEaXm6UETc
         waax4AC5FZ8t1DMjkrSsPe3H/RnWn3r/SFeddBL/9kToSjTewEEPmDBZq+k4MMKbOtBO
         pKweCSgmFtv7gsdsokLuNCRRfGjn/xKS69QJ1zIP7DizDQhTIJdB1rFgXZMQHDr7vnhk
         JGV74Td3YItqDG43HwH2Q4uHcJC7Q5P/1lf2MxDT7RMAa1pnjb9G5Sp1BfVhO+rLCK8C
         tlQEdGvV1RSxAbzmTlCxKrCqNNQNKEe+iNGGU9MGt6/pWdy5sqleEhamiucv2LY++p2A
         yD5A==
X-Gm-Message-State: AOJu0YwLP88USvVLfaheXYj3nPGvyJK0h0Jf4Tj+vC5uDZTtMJlPaay+
        ubn0J/edIV6EVsMxg3ETE5w=
X-Google-Smtp-Source: AGHT+IGBz9BJO+fNFXblCB6zsBxw0/nmGzPc1Td742lMyz/VKcdOyC4cGNWerXKPUrqX9Z3/E/jB2A==
X-Received: by 2002:a17:90a:fe8f:b0:28a:e30d:3043 with SMTP id co15-20020a17090afe8f00b0028ae30d3043mr640572pjb.56.1702495621720;
        Wed, 13 Dec 2023 11:27:01 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090a114100b0028b005dadb3sm275238pje.26.2023.12.13.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:27:00 -0800 (PST)
Date:   Thu, 14 Dec 2023 04:26:59 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Remove usage of the deprecated ida_simple_xx()
 API
Message-ID: <20231213192659.GA1123825@rocinante>
References: <270f25cdc154f3b0309e57b2f6421776752e2170.1702230593.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <270f25cdc154f3b0309e57b2f6421776752e2170.1702230593.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.

Applied to controller/vmd, thank you!

[1/1] PCI: vmd: Remove usage of the deprecated ida_simple_xx() API
      https://git.kernel.org/pci/pci/c/991801bc4722

	Krzysztof
