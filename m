Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12C075D060
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGURKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGURKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:10:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1C010C3;
        Fri, 21 Jul 2023 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689959448; x=1690564248; i=rwarsow@gmx.de;
 bh=1Yn5PYR+qi93SYdXj+ktO/6J1mUQKrGIuxJAgYEDHzM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=R/azHfoiQxe4EOxUUHNIE2xWk7UYHxPhPdsxxr4sSPc5Cs2FPGuBiqg0L9avfNiojXD3L4u
 ubymZfThcpeFC8aCjB/qOogZqtMazbNsn/mrUU4h/Q1OzHAOpfikotSt/mw3dIYSeiBfnh34p
 5rzSTj3VP3Q8E7kx+Eb8qTB6q5YO0n0k1OpimUn69XHdVMDDEwWKEfIkAoQn+enSVQrofD+KH
 JUrfweahFKPXCMDZQToSitVJcMZiecODXELKU2nbcTFBhO6yo9ksfeqQ70eWg2M9QJKIeD1dO
 Uvy5wtN0T9fGUUHoBwUNZ/uWoiP4kQV6G5SnKQ3Yr1DR921GoHbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.130]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1qXwHY1buy-00OEMm; Fri, 21
 Jul 2023 19:10:48 +0200
Message-ID: <d9035b3c-ad44-f4dd-976a-0b612cfa9dd4@gmx.de>
Date:   Fri, 21 Jul 2023 19:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 000/292] 6.4.5-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0bDbVDHZ9uoyb1vsEcMy9o9WtXj4X3hb3EA7i5GPTSfSncwr0e5
 rT1rRUH2fMI5MFCHMZYE8dIkTimKqXr2Y7oSJRqqtNM81vAzNQc/UWplwzIoeBgecFqNn91
 zjcsOw5jfaDIUOKMF9PUyn6zLUf8Cq4xJo5zKlXwedxGDwY7tDdM+j8bK/7o9Sjl/9s+mMa
 Y+DDKBn+SjHVdt5ScptnA==
UI-OutboundReport: notjunk:1;M01:P0:CGwMCBC9Zi8=;mZx9ksxvMdWfXEqEPz1AoXtwp8C
 R6gHgdcmUNgILJkYczR9zsgE3Bk+7yFK2YkwjeD1GDYnX+FAqzAIekJqion9aHm5RZQYklukH
 8zbG5gvv0mn1ZTKhEJnHKvoVl8fRlgAOncAxkHg+tRPJE1/rdxgnCoNYYtVnuL2XClbIuOciT
 dJFrTizMa5D/LTk/lPugt9k2uQbbu45daKVWVex7gu6MnRTlpS53i7PfCnJQQMu2kx/OxPrYw
 hcjlmU3cnTIWNAa8TQzVFDOMi1Ng8/FbR/x1sUnFZKj2Gga7WVth3Pg9dPSulkD6jyccuI8/2
 4A5Mlw7ZdoybWYwiH8Yc2NFa+/CqAd2A1sfbB+9RmRIsgPdBYCJpIHM2j5YwkFk41hsWifrUU
 ZZBlMQVgn32qqyfQPkxzWWNqBV4CadwrrzKVCLIC5cKKa8USwxN0LiF4OftyP80A8qTrspYT9
 XGVbvtZ7GBltI6lRxEN9XSTtEQsdiX2dlYowIKDYjVlD30ScJfUSW5gZOqT+b19sFeBjT13aI
 6G27accvSIZW3E/v+GCFuZP+Pzn1AkHvSVclefAwRa4P85NE3VTrq8A/3sfoo17LQN3xaE/+h
 wGCLDYdTJP5/itqHn72qHAVO6Fhk/KvX35/csdxgwLxrARAI7I9lwZz6cT88bGaPic9gMGMyW
 lE/A4RaL5sfhAQrHvRHM5LRLkyGscWbx8yb7R+orE2WuyAJYVXOfW2gD8OyQs3d8l3Z6YsRcN
 aY/QiwKKQ+J6Ar+O7pnRXWqh4u8LyDZNQ5vv1dnQ57a3rzf4b3/d3UcviaSJgAX5GE+lsm2rf
 U9RmXcG1h84bkijBPiZKrANJk5uBvLNcSHjma96Fm/scLaMOeSilHFZnqNLM7nFwPiWa96YFh
 QktSJn6z5bcOb5EIwNPHOB9Y3GOyOrEzG09FUPruDfbni4H9OZyMFl3p3EBSfLxCrhgPbBYZq
 sQratw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.5-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

