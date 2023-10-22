Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1AC7D2354
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 16:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjJVOJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 10:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjJVOJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 10:09:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99D6124
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 07:09:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so2417422b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 07:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697983777; x=1698588577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNRyv/8HDl5ApGs7GRS0h3obBTPs/1B6qPTq5HKPHO8=;
        b=O33sAigmthmOJgvjjWliVp/eKhRkyhidCIRygDwQdWidk/c7OMQr7yuzNT30Sd36vL
         y9o1vD4V9Hpa7GU8YynQIhEi7HV4zAVZac7zPb67OE0Mi1NhxJlF8H8CjEbHGtCe2oVG
         eIkKH+lwSmf9sLdJVVOMaRcSzF3BepbdBaUoghGKIKseYjKdtJgyIy6JrgVfDBnjj2Cz
         uf1srMcTQrNb1iv/wf93SDKgtVdmB7Q59mhV14+E6xFpg5fCHC8VZAHfx+25foA98btF
         HJZpRioDT78PAA1+3PLyXz9tL/uzD653Ivhy8CWnvY5GPWhDImDzCYQPkiSsE7zbYOzI
         fTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697983777; x=1698588577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNRyv/8HDl5ApGs7GRS0h3obBTPs/1B6qPTq5HKPHO8=;
        b=tg0kLCqDZCmWfvrmNzr/1Ugt/0gdgSSWawhPN+v7+VBoe1uiCPJhkRSuD2SvglPrwK
         RHPmw74B1/ZAwPCPaGODClS/+ZYJNoJ4H3Y4lpoci85ZLehJlaeGlP4zSMjII1adlab1
         lreqwv+y/uJqHqQRApY9nWbm6B0bEYn/4QY6WXrjC8IxfXhxpoJS077b6qkcji0o+RTD
         g1EgFqe6tlGahsDeRpHzs1ntmEtfbprkELHF/FXq2vhsd8CgnxOE5I3xWtno/Fh7DBid
         0y+9Y/vrDvhFtWAfT6ROC5pOQXcpsnpIeQi/eyzWMTRkD3xmRbhd9+/Rk4NUZB+Bp/Ns
         l+3g==
X-Gm-Message-State: AOJu0YzMs7kkL8goH0HHHQS9f3Hwg54eZ0n5h+MKbzw2UkWXNYeEmHy1
        ZQy3xl/pGsfG0IFRrShzNHMgKZkEY6U=
X-Google-Smtp-Source: AGHT+IEyYye1goLI2f0D5ts5Rcg7iPGWsVgxFR9bHRyCnOKU5dHowv10PpPIjY9ReKmDoVglgo32Gw==
X-Received: by 2002:a05:6a20:7fa9:b0:159:f884:4d6e with SMTP id d41-20020a056a207fa900b00159f8844d6emr9134255pzj.40.1697983777260;
        Sun, 22 Oct 2023 07:09:37 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b006be055ab117sm4691749pfr.92.2023.10.22.07.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 07:09:36 -0700 (PDT)
Message-ID: <edc8b3e6-d5b5-4d61-b6f6-fc4d06c37dfe@gmail.com>
Date:   Sun, 22 Oct 2023 21:09:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How can I get/check all the kernel boot messages?
Content-Language: en-US
To:     gmssixty gmssixty <gmssixty@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <CAOx-CDV52DRTmrZ7WEYxngCTpO-X7-H4PGXS86xC9vDJU9U94A@mail.gmail.com>
 <ZTUGCWr0EgAf4I4C@debian.me>
 <CAOx-CDWB+QQLyKoSsH=_HfwRBvOeaKKN2v5kAKpr+TgsE+zhDA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAOx-CDWB+QQLyKoSsH=_HfwRBvOeaKKN2v5kAKpr+TgsE+zhDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2023 19:52, gmssixty gmssixty wrote:
> I did not install any software. I just booted custom kernel from
> /dev/sda3. In that case, how can I see boot messages?
> 

These are all in dmesg output.

-- 
An old man doll... just what I always wanted! - Clara

