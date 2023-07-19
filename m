Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC57758BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjGSDBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGSDBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:01:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BE31BCF;
        Tue, 18 Jul 2023 20:01:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-668711086f4so241730b3a.1;
        Tue, 18 Jul 2023 20:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689735663; x=1692327663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBdhAihI/pvqPTCcmtBB0ArfD329ikLZodkvSFP3iRU=;
        b=KmjarVaF0CLu0X2VjzUfypGXT/EO9RM1swQd3UDyqF64ZwLURPj7HezfpXJNUOjmUR
         qupX/zKVH73vB8204BbPG8wHqGvqds1RrL6KDn0wwfbi7vbwZO60laXCdlxhGwOPl7Ra
         8ndr7jxPGuOY34lZ1qd9ZprImQe/L4VjW4l4/6vHvQ2nWluJ/1mOkLEn9p4u7PGwfcj1
         QQS2goeGxzwzD3o/9AWwlqwsHTskirxImTbbo87MQM8t2gsGO28tU2HQnjASaQm5g1/Z
         JyDsc0xUEcSiXZ4jKElRAKsftQKPtKEyoXDTq0vhHE/vY51+gw+pYSUO56DAt+U5C23h
         oUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689735663; x=1692327663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBdhAihI/pvqPTCcmtBB0ArfD329ikLZodkvSFP3iRU=;
        b=dBQkHCenTdE9dDwM8hboS2MOraLBJmdQZAVpPqjg0hQGY/aVllYsd2GHoGUv2b0ly5
         UMVCdvAUxeKZa4HGDryZyaGvpSM+ap3i0SORN00Ga7aWi+5WwI/ND32gBvp3hBqxaxua
         go+fuYtdSBBEilRykq2DzfggvPVejXwuoLPD1ExgxJFdR+ptdW4kgK82Ptu79CwCClmA
         ujIMfJ6aUc17Nb1auecvADr+lys9m8gMNAzAMjAM3cJhQR7UnM5v8BK2idgbAiKjD771
         6INrY0fn1JBookfAYWGujnnxrcTToimxoWuJqbfV3Amx+XCsIE/qQRUh7yc/ZLG+zSrc
         xb6Q==
X-Gm-Message-State: ABy/qLYMA4z7vCXu6maaE75DFpUj28xJ/O7RBZx5xmaZu+4ytWp+Ryyi
        1gmC9cYZytHSj2MnO4Q/VHQ/BPWz0CY=
X-Google-Smtp-Source: APBJJlGgxGAUyfDYuULzHH9cCly69Zj30aNV5aCSfKpMEgn2YmqAE/64MHTOhR++6KlqmoiHiXwOLA==
X-Received: by 2002:a05:6a21:99a6:b0:12b:40d3:aeb1 with SMTP id ve38-20020a056a2199a600b0012b40d3aeb1mr1303070pzb.25.1689735662813;
        Tue, 18 Jul 2023 20:01:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 10-20020aa7924a000000b0066a31111cc5sm2164225pfp.152.2023.07.18.20.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 20:01:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 20:01:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2 1/8] hwmon: (pmbus/mp2975) Fix whitespace error
Message-ID: <6a69e320-1bec-486f-9f9b-93b9d1ae30d8@roeck-us.net>
References: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 03:51:09PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Fix whitespace error reported by checkpatch.pl
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied.

Thanks,
Guenter
