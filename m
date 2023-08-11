Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4941A779379
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjHKPsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjHKPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:48:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA73211C;
        Fri, 11 Aug 2023 08:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691768918; x=1692373718; i=rwarsow@gmx.de;
 bh=xgf/WzNI0zTHw5Z3/AilTrBUC0Tmr6gHHfOGGeiqFf8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=S1kroyPszbJ/NCMkmmUozUA99PQ8+iGpnxgTi/9a1zgWamLZbMbmKvacRFb7s9o4XmYUK5o
 I7ICGQE5q72EoVl3VYQSOBymrGDe3+Xb4e9N3P6Hu25zkE1etk8Pu2rk1Vo6WHVTWqcMwyfsh
 FG2GvvAon2Yl3rcgZdtwpugkMHMqrCXgY914+TLEc3rNgXEKt0445HaGIFOI0KbOVZzSH9oOM
 qkdNhZX0l8CP5gulLKx3YSlRMGxOnPVEL4HiKVSxEkbIM4B0+CvpPV7rvmdMkksFc063yFQYB
 cose/vin38W+U9crXadM/1kBHfhgARJIfL+pKZMgtdfgZVNXyTMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.47]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwUm-1perCD3ShA-00uLtH; Fri, 11
 Aug 2023 17:48:37 +0200
Message-ID: <16a6dfe6-83c8-f9d8-990e-22f33e61a1df@gmx.de>
Date:   Fri, 11 Aug 2023 17:48:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 000/165] 6.4.10-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5bba262f-c3a4-fdc0-deff-da3cb0dc49e4@gmx.de>
 <2023081155-geometry-gloss-ab63@gregkh>
Content-Language: de-DE, en-US
From:   Ronald Warsow <rwarsow@gmx.de>
In-Reply-To: <2023081155-geometry-gloss-ab63@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vztuNJ+HluqwE/zOedi41B+e44Lqd1Vg2Taf5+gasbOluGl+OHR
 SzcoUeKYcWmfEwOn882LkdvJxeuNwWRmtn1bzAL8LcJGC8HqBu+I+GDj+TPk/e0Z2749Gaw
 LCPqtl8RTiONOdwrZPx9+TCluzjg+nL/hfpZsA5SpUpKKETkCuMWIYOpUjrkkcZRtEH+YzE
 ek8U7pHXl8anZfQoEKH+w==
UI-OutboundReport: notjunk:1;M01:P0:iPS6c0kTWGg=;RnFDhfrLxY17rs4zY/AwNmQIf+v
 35PMEHh/iwMqUOXmil2NEvk34ze8IlBr5dUBf3XIZRkar7/TKthFydYZtIjrwaZKAqb5cjNE3
 Ts1vm+LIAQ1X7zrKvUBpPC6IFpGierKcqelUkoLFNqZgUp/fL73wFa7bCSImpw3jYt88hG1aF
 jTUqpKLO11X5/Ku0n1k9EOnI9szK0WTjYzUuLOF9Q0n/4y+VzbUcrweQq2cdZQqTvvqbi7/9w
 HNPUsGQREPPg6MlbyuIPiGlmP70QJyxQECzAoQPbAFoiMZxV/Cnd90o3xkU2FUCl+TUH8rPI7
 t/WRfubVkhqT+HCM4xakIVYkOKVLwnKYBD1aiduk52up68lqpLETVEmWqy/ixMhhI3hmIBRN+
 jvnWZ7Ae4WKE/A0jjtU1mzI03wIvp5U4qWQeQkKvHtSnamFfc4QQ4WXN5atYUoZ9g0F0fI5Wt
 p5HkKO7R+H/SUmnysOAZjy5qyoq1rzLkmnnrMu/SkGr0VGsqo5KEhXinYnAAqear9Gped6gkR
 8jZjbUD4gVKBtq1o3iuiK3mm9FIUn1jwZIXSJWLGNt5mz/K1zfhoJcHYE/QaHB1x8qlB3bkYQ
 gzkls8UioZpLKPIwHlaXP42LTPnIJSf18P/TI6shPcAVeVwBp0g/+YITMEGMMvgvPhzw+g5oS
 nX1WGOK39pm60P45jDxkDAFE74JeL2d0Ev6oQWco1yT9MEIIvR2k5AA+9JVfjM3yB3Br47tbF
 I8OCtOW7eUvo4rhP6qTJ5DAljrtvuMShsg3MEnS7KGvMR54PCst7YeN8+4sAtE7q384Hv7WPg
 sRr8hyxxdcRNxfuTA3qR0l4SgtgHPJfPD0FvlGQ+lsUqoyUmu+BnVPTYe+p9PQ95aMeoVLHVy
 YISNWexM3H7fhNBmyOkc520YM0DKtYY+OlVDNhMRQP/oj139rMkfDtEVcWFmksoD0LbnQ34SU
 OsaTZOv8POXmvw9YmLnM2gD+Lng=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.23 16:16, Greg Kroah-Hartman wrote:
> On Wed, Aug 09, 2023 at 03:40:48PM +0200, Ronald Warsow wrote:
>> Hi Greg
>>
>> 6.4.10-rc1
>>
>> compiles [1], boots and runs here on x86_64
>> (Intel Rocket Lake, i5-11400)
>>
>> [1]
>> But I'm unable to compile vbox external modules anymore
>> seems to be a regression against Kernel 6.4.9
>
> Please contact the vbox developers, that's up to them, they have to live
> with the pain of wanting to keep out-of-tree drivers.
>

yep, thought and did that

for the record:
https://www.virtualbox.org/ticket/21796

=2D-
RW
