Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E827E2591
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjKFNdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjKFNd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:33:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542DC125;
        Mon,  6 Nov 2023 05:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699277600; x=1699882400; i=rwarsow@gmx.de;
        bh=e39j+u5nhKmUY6Y/YYmY9yLI0830P/dNBLtVUkw7q2M=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=CzFDp9BI8tS2evaEUDIWo8HybGad3XEzKBk5cO2ttysJDG3LR/CRj5io1y/S+VF6
         QZsBTvx0qWp5pJVWq1afFRm1kcywISMjWRTI1+mI2d0Fnc1f2bPyI9C41k2jqjRxb
         6RE0UmKO/cb9oM5g9ArHDdwS8fQpIz1BP9On85tI5+LBfsbFAe/jKMT1cFPgYlzRT
         dUrib8+pQY6sQgtKzBYN0Rqbm5qpNId9LPOx5DYwDgLxCZVTbv7oOV+W11KZdszQb
         WypZzZjQUo8be0+MUnhxONpJRamAnz1dMuKN81zYLqyx4WJXcRkw+7vNkpGQybJRX
         MTEqlo1+OBdgahXwxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.115]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42nY-1qzzjE0oPg-0003xQ; Mon, 06
 Nov 2023 14:33:20 +0100
Message-ID: <fb4a1dea-241e-4c1c-907b-ffeae64d47c4@gmx.de>
Date:   Mon, 6 Nov 2023 14:33:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.6 00/30] 6.6.1-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:b9kUwxS7uLdrAxzLx7xooVQjFDVvE5X4gPvw6wCIX/ftvUldvky
 XtGsUTKs9jZW/13QTKEnUBYRr+zcIau2Fu6Ow9MtjUxbx1iSnU9wHJLBReQ9pTUvf0kiMYO
 6un1rnJtXiny8OxFH8oN2FWRFK5cf7K7WvqxL0bJCnSsmgwEBlEXYLQd1o/oB5Gj0cx0UQg
 6FMeWlcGCDizRWMEMSfPg==
UI-OutboundReport: notjunk:1;M01:P0:efJ8v4b2BPo=;fBugDu8HHtzxdfbooJecWChUQC+
 9fBTNqLZmxxymotMV/4N48Vd2RHNFjEBcX+XR4FU5sHJsoQ49KaqeupZluLoSF4SJyF8dwWHz
 bRxMrrQiLSoNxhTPekR0Np6iTR6vgbNaclX7D+pPcQgYH/WVVzLJwENPLz7HnwUdVO7vEvHon
 6oOmwfAnnmbRhzUOoapOF168cVWK2+536mvGhUNDd8vt1zyhQELVI6y5mEPDb+mMXItVSBIg1
 6Ek7oRpo9vjFdjX+Q15XIFreKJagmxJfJGWDaYgUDRDiJgSZBWlqVoJ7jd7Ie9bWOURAKNfhR
 Y4s2hiT0tGx4YZVnj02c3zQOACgdSs7+c2qOFmKKwGFQsCml/TxifnrHf059ZTLumj3TQZXJu
 LeC7gtFvUZM5ndYJMAX9jm1yeQJCitoI5iolmOvBGU7pteOXZGnh1Y6xEUSmDFZsJRA4+GvlL
 7aVTa2LcOaV+ugEXocR6B8lpJYSkUIpAOn1UKmAN0Bs6LyC6qeP2NYPtixPp0DmAdVGwuhI6r
 2454H1qgtE1utuSpY90iN7SV8h2xmeIU61npzwmg/yk4wnWMn/TMHgA0PgZkXVj5IAlI8uxVq
 maJKRiC8PMtR7Q2UNCNsgkgLtO9E5WlZRJ6ZsmktwUYwQLny5fiVWitBC2YCTHr56qwyOqtNc
 bji/wXFFDttoWNaKMsLb2PMuEr47LGDguOvH5CFnmQzxZNj3HytIPs6VhnvX7jN6eDbSt4cty
 5WqY/H2ZXZGs5RgnuVba2xrR/bMimc/tvzExBIqlMRLH0lbUVK34Cb1fBKD28cTOa5tIckImb
 Y2ag4Ft2ma5j3pvP4JqU8iv+TeQlAGSdbP9Asluzfw1Ty50xkhsunZy3NdsnVsNMA2/dPpMqp
 xkuptfz9WRNPqbeng8ekqxxS+hBPRCvkME2mfET6lMnEZaLmF2X+jRhd/yxj3PvgDkrHgZUlN
 mEl0Wg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.6.1-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

