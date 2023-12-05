Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F90805BA2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjLEQmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLEQmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:42:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31D129;
        Tue,  5 Dec 2023 08:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701794573; x=1702399373; i=rwarsow@gmx.de;
        bh=coHe5WCJY39d1Uv3/qMYCpaKNWEwv8yrks7juxiis4c=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=c3tovBj4JirzrbA0nNptsWE9+kSMc1pa8g54p1XKRoWylp04W8VqSnS9RkEz681S
         gIH9GGaLcqPA10CawCE8Ds2kxLB1KvmB7ZjUfoKVtbXGU+uYQDWCQKftF8vowGK8T
         MCQCQmpcLhx3CTMbfalIBSZc3lyrkOCUlTTU2HmLyVP63wcEIt7DUFdzbsLygMPiX
         Ww6Cdwy9xfvGINlVW+FDBcAuMBU90e8pZTajYqKJP//+UVewp0LIom6CyIO5NOYyo
         C0ryTfgUSz+YEyN5D1r2hPkW9af5g3StsEpSnryi9zOT7HVhjK34HFTT2YQBlEz5g
         mvM/vFTIrqj1/i3CKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FjR-1rD0x93LaZ-006QOx; Tue, 05
 Dec 2023 17:42:52 +0100
Message-ID: <f0a463a7-6b84-4700-b8d5-87005c7e5297@gmx.de>
Date:   Tue, 5 Dec 2023 17:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:otCVhkPgV5F2NLGqYIRvMZHleOHoHTaWafCNe3V9Ga9pPKEK2tA
 KmVVeX6ee10RORtiJHD7TO6/uWVZj+aPaLJFMVNPmmu79FjBCTZTIftophll1cJ1ELJhcJC
 eGzgOvhMy3G51LRy/E0GVrQ0s+xuXbbtcLSaN9HNwwsLz5sFlGKpSSDSS6rY7Gtecc/Gkb/
 FLtyd6EBW3qXQDo55mwuw==
UI-OutboundReport: notjunk:1;M01:P0:sAwalaS4Oag=;+LUaXsf64OEgBrGqVwgRNytxVa2
 jXeaP6YrLwceSG6+PH72MYJgbbtve7xzjijMd4qdgncPuO3xfeJ+g40VyB+/R+2Whc2uiCjRi
 +Y2tP0auHBAUOAeGlKHR1MalAoQY0DzQ9W3cWan9cq462eHWGFw9tS3+j5GX1hNQU15+l56mE
 BVJFmMSad9aN0JsZfkwbxhG6W7T1vdyg3QWJcTuoUEZeTCOw2bdHYMKrKyaT4TJJZRjPlWYR+
 gSqHCx1hUqJKoZRSHo2gJLw9eL2Moy3LOtgOKwLX3kIIbSfHRiCuxakQJ0ch3XGaiqtxrwY1i
 oCTrMLRyI/grFmgm+2mdFCPbX7czQwjL9ioe1JoHyibafDBFm3OnlHXXgiW7SmxZ1EDXYM/V8
 Q5WE6d3jV85fHjbSd8gEfVqqnnyNKG8KBPz5MvWXMBsqrbBzsvU+atWVlMKcVRtStSUeNsjTg
 M4+QS+f2NTMoOQ0+/8ce74Cd0Z++wiWN/bhZv7ZG9417Odtt4NbF5DlVvdkc3IcQs7ImQ5wz1
 c2oic1jGX+hLH39rQ/j1V+lq+QrEnczmrIjpE1u9rfKBV+rv2RWDFz4MY9mVl7UWq3p0zKx44
 +QCl5cx6Dm45biBD2Kihzui/pPDA9SbydtF7KM+cv+JxHoNN7BH9QLUkD5r+zKe7uNUGJQwy6
 UWPjixnlZ+7F34ui1C0ma+/w9RVvZtmJPiClFPipd8NCxPZKLgH2F85mB+1nBCVNp7a1VSIn5
 lCBwdytxfMMCQEWzyoS7/GnVocI4bqdYTkV0xId1ll4k6qC6c3iTuXl1tkyxnXr7CCrq0xLqO
 8Mmz7zjZ2ED54P5cbg8vZiIpbZNZ9BgCl5y7RAqUGXYHKxRUZcaUn4jYYHaTkCVlxHWTjufXZ
 QyIvjpKYY8adAZE8pN5cKGkNddAMNEPOZWY8VCzaZq6Jzzr/wfvHTlKeZJ9M254RgYhQej6IQ
 wlwni6kWusD+2Wo+2xatqFaH1Sc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.6.5-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake: i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

