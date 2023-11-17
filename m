Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A59D7EF80E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjKQTwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjKQTwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:52:14 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76945D5C;
        Fri, 17 Nov 2023 11:52:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so20639535e9.3;
        Fri, 17 Nov 2023 11:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700250730; x=1700855530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H72nPbGNF+k6x+gaqimoQnUqxi3F+ArW9AE0eBa2hww=;
        b=kxeIRAXdUQpWFNNhbzFdxaD3z3+8SgJudhJZSGf9HAcATnZOGL600gAdXX7N674Isz
         kJmXIUyT1MYE8j24Kqd0+0tyJsmcgmvOg0vpB/wM5HUt5RJTpeDyEwHC9wuv2KlEqJ13
         VJwoDb0758FsmFpqjXPgW59bzVz6z4YuKAamvrWX1SEGua9jk7I6Xq1XqJPRxTHOMhw1
         dfC9lqIRviXqPykoJncqKXrUSJ0VpyiHVkMCAp0AEjKXXrOYaGpaHY2GEpY3SKcUlixX
         TIxkGfS2G3kfulAXtmmWwD4IcbTRAr94tun0gpnHbgkIkTHuebzSm3Y+nEE6RS33n0Ce
         iA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700250730; x=1700855530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H72nPbGNF+k6x+gaqimoQnUqxi3F+ArW9AE0eBa2hww=;
        b=Mr7y6q44eHhhlI9cLk2yaEaku3NOsB/M1YJUYCqAmk8EmF7yugxUQODizYyrlgqfzZ
         1Vu2+jqROajDGiAQ/XeVRA+Le9TEuzibC9UHplBgvxv5l8hT3LkKFuaFiyEGZvN6okw8
         JQ16+5jlIGhPuL8LrHMAMH9dPR8ZtpOqG1hzWNyJUpcIIGjXjy13JqJj2unOw+A86ncE
         pHvP72KIlEMnXYZMjN/WiTg9eY3/CGFoWbnZDv+02urGdiPmdWt352B+taet3xrAKE6q
         tdxhP764vQ19UUdICCtoQ9cbZL7WIgYFID0XLKbEHevS0tyVUasybQ6qaV6eqWIyHIym
         Gqjw==
X-Gm-Message-State: AOJu0Yz/FO9XoTWGbvU5qO8kwuhyBDr9P6PLuLBLzV/7qa5mgRwA0WCM
        /xbmR8Z6bR6oCCz2UPsOe/ZI7DnvDTJVWyJL
X-Google-Smtp-Source: AGHT+IHhrzahIgmhZQbyz3usaR0We4oOYkpRGHixvhnxoS0NNd3NlGSY7ifUnMUsqYS8xGJBfn3MBg==
X-Received: by 2002:a17:907:6d01:b0:9bd:a73a:7a0d with SMTP id sa1-20020a1709076d0100b009bda73a7a0dmr154948ejc.13.1700250709138;
        Fri, 17 Nov 2023 11:51:49 -0800 (PST)
Received: from [192.168.1.99] ([151.95.113.104])
        by smtp.gmail.com with ESMTPSA id d2-20020a170906640200b0099bd7b26639sm1105282ejm.6.2023.11.17.11.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 11:51:48 -0800 (PST)
Message-ID: <b4356286-368a-49ec-b1f8-d7e5e4afdc25@gmail.com>
Date:   Fri, 17 Nov 2023 20:51:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hid-asus: reset the backlight brightness level on
 resume
To:     "Luke D. Jones" <luke@ljones.dev>, jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231117011556.13067-1-luke@ljones.dev>
Content-Language: en-US, en-US-large
From:   Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <20231117011556.13067-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Denis Benato <benato.denis96@gmail.com>

I want to express my gratitude toward Luke for his guidance and his help in submitting this fix.

I confirm those patches were sent in my behalf.


