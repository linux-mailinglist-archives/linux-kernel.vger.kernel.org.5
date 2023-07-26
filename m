Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91547627A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 02:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGZAId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 20:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGZAIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 20:08:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13071AD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 17:08:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31438512cafso5596134f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 17:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690330109; x=1690934909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHPbHY8oY5HmfAAYSv4idqB5y69X1Q32uHFTUAnmGks=;
        b=Q133PrTyEAw2k14lFs7TdlA3krcZYVS0IaYhouRSuLpbGvDaE9RlgNRo3c5Tu0exvM
         NeBLq+pZLoDFdWpZypaKlM+zo63VuXPtZKBuUK0JM2Pjy8zPX9uW/t05pyB2xfyq4Pku
         SCKS6EyPppVKzyxJnlrd95qlGSE82D1xFs67XCz7pizvr0H8nb2rSlXAeUX4TihxvJ4a
         ln2DHtWit/jXpBZtnh3Jz7iJzVAGgT9PYxqN4DIz7uCii5YxnKnMofWEDvrOmHNMQGjN
         7Scglsn5JqBdzd3nzamoIB8q4NNfJWHksVYRSQiX8Hf6Pv7URM02Gng8RA5bZrIO7AXO
         aTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690330109; x=1690934909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHPbHY8oY5HmfAAYSv4idqB5y69X1Q32uHFTUAnmGks=;
        b=MSyAYxZOlcmwqKVxgrwHfExB8nXDEkSmcL2X4MNFIFle6wkVEXZ+1dE2e+0BN8cDXC
         DxDTI9weASCdWdrxWm6XjQPlEWJ4iVkPULSnAhe90lRnr4uzcWypibFAmlZHrgKteP6a
         6DRqnZid3mznra9TbMVdm/mjRq617iZgXq8z/d8nCu3VLDoAlRDFgUWr305itkdS60UO
         1cJ8l79+bTXGRVHStEPi8PtgX+8Z80QMY9A65KbvVBWHFjViagrOGGAQZHmCzNFx8dwL
         Rbd+koDSE45cUl4cwpOiqh5Vu7fojRIuePuEQT8oN5U3KMB8egll/pL1Q7LJ8+bYQIns
         qBdw==
X-Gm-Message-State: ABy/qLYXD3ab9s9oun5c6pTTN+rPSz3jl/ZajY7/94liF100Xu1uvkq+
        m5sqD5bF9teMsiemsthAVxY71k2Ac005MA==
X-Google-Smtp-Source: APBJJlG48tOtl+jbIVsuixIhn1YUoPD93mO0QwZSvstyA60emgKfcAxJOV56B0Fyd592ZVHUpN1O/w==
X-Received: by 2002:a5d:4b8b:0:b0:317:6cd2:b90c with SMTP id b11-20020a5d4b8b000000b003176cd2b90cmr223450wrt.13.1690330109130;
        Tue, 25 Jul 2023 17:08:29 -0700 (PDT)
Received: from solport.. (173.red-83-42-47.dynamicip.rima-tde.net. [83.42.47.173])
        by smtp.gmail.com with ESMTPSA id n7-20020adffe07000000b003176c6e87b1sm3406455wrr.81.2023.07.25.17.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 17:08:28 -0700 (PDT)
From:   =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To:     Steven Price <steven.price@arm.com>
Cc:     zhengqi.arch@bytedance.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: shrinkers: fix race condition on debugfs cleanup
Date:   Wed, 26 Jul 2023 00:08:26 +0000
Message-ID: <20230726000827.724389-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <c7dbaa5e-f5ae-5dc5-4063-b8099a3058e0@arm.com>
References: <c7dbaa5e-f5ae-5dc5-4063-b8099a3058e0@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm, indeed linux-next crashes with a null pointer dereference when
calling `ida_free(..., -1)`.

It appears to me that 69cb69ea5542 ("ida: Remove assertions that an ID was
allocated") didn't intend to make `ida_free(..., -1)` invalid; after all,
it was authored & introduced immediately after fc82bbf4dede ("ida: don't
use BUG_ON() for debugging") whose commit message calls for making it
legal, with Matthew's support.
And the referenced Bluetooth HCI code that also calls `ida_free(..., -1)`
is still there, as far as I can tell ([1]).

Rather, probably the `((int)id < 0)` was accidentally dropped, or the idea
was that it would be handled by the `not_found:` label in `ida_free`, but
for that to work you'd need to change the `!test_bit(bit, bitmap->bitmap)`
condition to `!bitmap || !test_bit(bit, bitmap->bitmap)` since otherwise
`bitmap->bitmap` is a null pointer dereference.

I will send a patch to get it fixed.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/bluetooth/hci_sock.c#n106
