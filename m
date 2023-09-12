Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29879D41C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjILOxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjILOxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:53:33 -0400
Received: from cmx-torrgo002.bell.net (mta-tor-005.bell.net [209.71.212.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BADB115;
        Tue, 12 Sep 2023 07:53:29 -0700 (PDT)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [174.88.80.174]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 64C351170481E878
X-CM-Envelope: MS4xfCmkAkW7W9v4MCwkU99pydEEZuIfDBpw5wY41n/g4Ig8ymFil3yAGTxtX2+qFi78Yef/k0DfKSja6LECxgBDsEpSMVicOHEV0eD0pkA2lOu004THcs2v
 BM0DT7xy8MzSsNUsSSsrItf+I5hz+jYCxtIRYZpsazlKvTA8aMzEf37Qq6FtgXKJ7jwdFuH2Fda+6gbb2SlOzagVW2FZvKl+yVrfWo/oT9im/QivGj0fkW4f
 z6pwuqmgBQ6SvP625dCnXZesy/PJs7PPB9XHo7ahTG5w5uAP1oQd5BAlfQOaUK58+wipU24THlKNqsW/qNCclqpcz1n4dS7b2EeYHKcLfqgLfbEqUbvw3SEi
 kf/+VX0bf1hQ2JINkLQJAC8v/2hGbTQr0VV5c37uHKsZamMQzqDUKPUGkNWsaqSs+bsgCgZ7hLfOvs9euf4ZCKsKn7wc1A==
X-CM-Analysis: v=2.4 cv=GskhRm5C c=1 sm=1 tr=0 ts=65007b5d
 a=NkkRUIc9Fga6GQ4JCcDOLQ==:117 a=NkkRUIc9Fga6GQ4JCcDOLQ==:17
 a=IkcTkHD0fZMA:10 a=_A5TAQVKAAAA:8 a=FBHGMhGWAAAA:8 a=C-rdEVRR2vpOvYCaZmQA:9
 a=QEXdDO2ut3YA:10 a=ypw9U9_ytwuNp2HAL0_X:22 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (174.88.80.174) by cmx-torrgo002.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 64C351170481E878; Tue, 12 Sep 2023 10:53:17 -0400
Message-ID: <bac3d143-7730-c406-14e0-72a7dfbc8d7b@bell.net>
Date:   Tue, 12 Sep 2023 10:53:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] linux/export: fix reference to exported functions for
 parisc64
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230905190828.790400-1-masahiroy@kernel.org>
 <c8a92dc8-de78-7484-bcc8-d4a91bec77de@bell.net>
 <c6568683-86b4-c48d-ed37-f1f87677eb44@bell.net>
 <97859bf1-c8c3-7294-8322-b0c9c408ba5e@bell.net>
 <CAK7LNAR_4rVgAQToSoYmbgYnWoSpowcrKi2ciiH9HyhJUGdmWg@mail.gmail.com>
 <CAK7LNAQQ1Vp4YtvU8Bq9aE+NWxnnOTX2dcZ5Gc9fC+vjRmCe4w@mail.gmail.com>
 <CAK7LNATktSBFe=7cE8kHEGx2R90iVV6AJsCfgg5ZD2+ssMmzow@mail.gmail.com>
 <040a0941-936b-87ab-aedd-5a933383b500@bell.net>
 <2eb1f861-d66f-edb3-17cd-84c90d92083d@gmx.de>
 <d04d6acf-ad2c-e93d-9927-f1e937c7f1e5@bell.net>
 <1870f4dc-fba4-26e9-6ec8-43e23cdeef12@gmx.de>
From:   John David Anglin <dave.anglin@bell.net>
In-Reply-To: <1870f4dc-fba4-26e9-6ec8-43e23cdeef12@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-12 10:05 a.m., Helge Deller wrote:
> On 9/12/23 15:20, John David Anglin wrote:
>> It occurs consistently on my c8000 but I'm having difficulty bisecting it.  Trying a bisect
>> with --first-parent.
>
> I just tried to boot the v6.6-rc1 with Masahiro's patch on c8000, and it succeeds as well.
> I've copied my pre-built kernel here:
> http://backup.parisc-linux.org/kernel/linux-image-6.6.0-rc1-dirty_6.6.0-rc1-250_hppa.deb
>
> So, I think Masahiro's patch is basically ok and probably isn't the root cause
> for your udev issues below.
I agree.  I see the udev issue with the above kernel.  Continuing to bisect mainline.

Dave

-- 
John David Anglin  dave.anglin@bell.net

