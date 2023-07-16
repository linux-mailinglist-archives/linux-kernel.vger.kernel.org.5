Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5355875555C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 22:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjGPUkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 16:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjGPUkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 16:40:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891BA9F;
        Sun, 16 Jul 2023 13:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689540003; x=1690144803; i=rwarsow@gmx.de;
 bh=pnqGBgFdHuCozk2KNTA9bjN2J77lokj4UuryrLPPUwI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=OBm3gxfKLYTlUyxM/5BZopDslMQ/JNM0BGZzi/np1ghmKH8v4D8h5mXCjYeKuZprNxicdxg
 geaHynNykg//pWhxaThBzOTHpGX7LNx2aw1yEUrBh5dcniCtJRT3jVVCRImVtU5pisgDZ0BA9
 KvBkQgZiRtESclAsvQ+1PeMdGflbcoEQpkwPntgIsbzC8OQOHzVVpupguN/Exkm0sGomN17SJ
 /WkXGTJhAwja/a9PfSWy7cDUkS+9EMraw9JQsCYrD4RWAKZbKt34kcx1M1xuTjhDVyN7ORYcC
 FMv9kOF3hh/IaqxmIXuRN1MmgwoeEMPVq75CovR+8rKY/Nd3slUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.249]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1pqQMd2dI8-014BQe; Sun, 16
 Jul 2023 22:40:03 +0200
Message-ID: <f7a5a41e-789f-71f5-fd85-649d012be123@gmx.de>
Date:   Sun, 16 Jul 2023 22:40:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 000/800] 6.4.4-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hkiGn5PJI66LSk4oicR0hjcoVDPkS1IhPw4JM1/QkmScofAyOAv
 Ka+uAVb165gu0ZeACJil2so5jfiPZnLXw/4dpcGK9nY7O44sFl9bpjYl/LD2NA8cDbxudIp
 jC4P9fhgicnfs1zig0BRw+PJJbu+DOTggCxo1h3+TBAlkmHmAm8iqSs8+8W4ihK6znx+Cjk
 Uv0pD4q9jKCzWsM1h0M8Q==
UI-OutboundReport: notjunk:1;M01:P0:pJ/69lP4NVg=;AxJP8oK7G/j5aL5kku/E/8YxFUu
 B5UAL8RPoG72RmqwGn+GvfkGxMb0HKS68Tbh6UEz7Pk/bgiumHiS8xbkbu6C6lBbQPLBqUazf
 P+L2zMh8IvEmWBfEdlD/Y9WmRMdPAWlz+cV7T/vKwGrPpHuLHnpZaG+ErVSqCOkHSnRngHjr3
 xoV1dU8iXkSlQFlgDZdUTu75YanvZ6GNsAKD5EDBvqp3agBGcPv9h2OQJSjYcK6Zy8v3nQMFC
 ZNu+E0ZL/mizH8NuDK171p+1mRMXUn4egHsNspUIE8xgPRvd64tQTMBLCNkWPuSXlDsOTBmTG
 mwM1zPr4FJ7s2i6dnDt8yvo2jsvhdq0GRHK60q6PY9CluDiwsTrox79HAHvongjnGD6vY2j0X
 8YXJ3341Ea7tAet2+YdrVCUR/NJ1YjsPcxa1D+fWbvmhKKhIwTXrNhRGtc6I61LiuAozy5qnX
 +tmwyonNG8SZ+45wf5qLxhuPGkSV2VrnHHoEjGNH1LeCbDc2tXGalHcu5WwX5v2Jv2yYYJVZc
 gc3UeKyt6RY4idMyI+w7SaKkvxI2/FlktHolUuD6F0NFbY3ZPUztxJWwthSDPMYFrKHy+ucgb
 q/Cfl43Gm9LfzWzrmRfaf9iUbegqBgSuYfF9COMKfB7Dwi7XzNbHpPRMQ/QcIYDXkC5Yo8gry
 8BTDksf/IV77Rcg5i42wAcqm4/AzQro6+PxV2jg86bNxIZOA71HHSyYFE+PqwP8GqAWtk3rIb
 8f+yf04TzDiYkxGLxulK5DXb2J/GOY43gs1KVVUuUmykzHXzDCzuKWwzHbii3GscX7V4fxn6H
 zUHOP1h40Py9t+FjaxIOaQHfhNJ08cLsd3iSIuPnJmLPgqf/8Hor90et2wCSK8nd3JXMdmYK4
 90ghE+a68kzSaEtRFXkRGM9lHQfuFy+emE14y7beFZN0H4swfkGMNH57fn2piAOR4+kP0PiyL
 H3u9J2zoAVNobLWgrgbrukyhn4k=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.4-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>
