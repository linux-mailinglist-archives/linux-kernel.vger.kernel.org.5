Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E365B7B8C0F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244617AbjJDSxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243862AbjJDSxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:53:11 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D3FC1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:52:44 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-351610727adso41265ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696445563; x=1697050363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+P1BMC6p7KesZ1QLneyQfNbStvb0j46CXO1yZ2rY9k=;
        b=OmCA0zH5hxz0KNLhV2y45fdtmnHIEkqhcpq3kvBfJllnNipxEubTY4JDcpv99ymcjX
         qT37VXm/Qxrq4/2OIizbFKbKGzNzqUJ92O1OCq8HGLeVVm3uFgOAH7bBP/yGTnsEZxEU
         O5admmZ7ICG3K6P5GlUTAVF8qeUqAQCEY3SSSk1424/jP/W+l8O1UXPpITKzIz7HoSEr
         u2jTeYwOGsDAIOD8AcmbwJtnUY2QdacMu8dGfi9S8ZzDaykZeGf93aogjjbtQrsymwE5
         CPkjsXWtn5cvVX3H3i8Yr++RQ33sbN1sbM00to5bh1vYpG4tpwL2Kh/G82KePZjBuUYM
         2HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445563; x=1697050363;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+P1BMC6p7KesZ1QLneyQfNbStvb0j46CXO1yZ2rY9k=;
        b=Ez4geNdCu9/Ou/EcCCjBgFcTmipBeKcQW/VT5R1gp1+Xew4M8458onwJ2Vv2WjHHq0
         dvou3xbV/YAVvBrI0SNSj0HCG7IuckvulnuPQm4KDxq+Dc5ZQDT4iONz6HMta8wl3I2H
         FNKQQD/tWulUbXGfgW7yd+jW1qw31i8bL/8LYZBhGRQl0axoAZvYyweYVTCBIzbNCcgu
         Xe2vGo2UA5mkmyuitI4AK1Q5FiOfIeTjdbvZbakxI7xpF6lNp7u31P8QamQPJvqtqES6
         KKVfQoV83S4jc/Ef+3c2qOyzADRu65SQY0FQWgQR/WG1bwpkY3yhJqVrVJ6ZpsJNdKRV
         GUaA==
X-Gm-Message-State: AOJu0Yw+we3pAK6HTvqBmDDnpCG8STTZHcgC/zny9zjjIcqBpDaRwsS/
        hYbuim7WTHhfPxtdXKdx+Sh+0w==
X-Google-Smtp-Source: AGHT+IETEG6pRPM9aDjlY3zLGtVT0VvyuqBH+JiMSjf/3mZu4Ua5GRk2AksYWgXqvA4Eu5+m/g9bzw==
X-Received: by 2002:a05:6602:2a44:b0:792:9b50:3c3d with SMTP id k4-20020a0566022a4400b007929b503c3dmr3746676iov.1.1696445563303;
        Wed, 04 Oct 2023 11:52:43 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gs10-20020a0566382d8a00b004290f6c15bfsm1138633jab.145.2023.10.04.11.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 11:52:42 -0700 (PDT)
Message-ID: <f5d66783-b8ca-4f81-9d24-faaf00961dc7@kernel.dk>
Date:   Wed, 4 Oct 2023 12:52:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] WARNING in __floppy_read_block_0 (3)
Content-Language: en-US
To:     syzbot <syzbot+06ecd359d1a53c832788@syzkaller.appspotmail.com>,
        efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000003b14000606e7f15b@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0000000000003b14000606e7f15b@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll keep saying this:

https://lore.kernel.org/all/7df3e30a-aa31-495c-9d59-cb6080364f61@kernel.dk/

but apparently nobody is listening.

-- 
Jens Axboe


