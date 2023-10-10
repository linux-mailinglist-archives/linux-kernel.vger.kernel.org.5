Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723677BFBAD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjJJMow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjJJMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:44:50 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A491199
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:44:48 -0700 (PDT)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
        by cmsmtp with ESMTP
        id q6irqIMg4ytxcqC6SqAADL; Tue, 10 Oct 2023 12:44:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id qC6RqymJ38vyDqC6RqyExJ; Tue, 10 Oct 2023 12:44:47 +0000
X-Authority-Analysis: v=2.4 cv=fq3P2X0f c=1 sm=1 tr=0 ts=6525473f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10
 a=jDH3Shn7vTvwIdt3UFAA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=w69pY1l90qXB0+Na6v5MmCnARPNAj99fld00SExm3i8=; b=n0IIPU70CeF1gla0g/bB3sif3p
        0IQJuOZxW/vc8fXodjZTtPNS/9Ocyqvt7LepwbzuysMJMSf06kNIwKaLWwhbndcC6RzBtyNpO0w4H
        efqGQ6fF192ZRjuHCgkmmwLvefCI0zm08RvXQxm6+kmz3YbzoKcbvEi5SWNIw/5t8RQFUzQ7FNai7
        Tk5cXaEhRP9Nz1rAOM5BJqWNYrX2AhJpifnTrgq8kI5JKxsru4wvGnvk1JFnL9UoMXqIF3xXmZMHD
        rrdrRehvta5S/dD43ubSvEWG7ZHAmEZUNKRWUDvtwVBQJY7nCY++ZyQslmEI+Ye9TrI04ywbO/DEt
        qC440T/w==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:57606 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qqC6Q-0029an-2c;
        Tue, 10 Oct 2023 07:44:46 -0500
Message-ID: <584b8c6f-a77d-482f-a33e-c6043b080b3e@embeddedor.com>
Date:   Tue, 10 Oct 2023 06:44:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] hostap: Add __counted_by for struct
 prism2_download_data and use struct_size()
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZSRXXvWMMkm7qqRW@work> <202310091253.665A9C9@keescook>
 <169f782e-9cc4-49bc-9618-ca6acc526e37@embeddedor.com>
 <202310091341.74A2D82BB@keescook> <877cnv57cx.fsf@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <877cnv57cx.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qqC6Q-0029an-2c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:57606
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGTBNhB18afu1HLsoOlIY6PADhJjbJB+/bY6MgzYin3GmkS1uEaiK24LXEu5gXys2aMHw4to3BNmtVAeaux2/aD+Od10tS5DkdpFmCWBuPIlSrqoKmb1
 tDNqBK14e+ouHAlhBlPArLHBLF1VQchKYF4RCgIFaLp7aESH6+qOe/4Lz+RRPUBKnlAUEqxccBJix1Ah1qXmlhRJ7g2HQhdSIPTmsG5ba7bNy4NGzseIB+0C
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 08:17, Kalle Valo wrote:

> 
> No need to resend. I marked Kees' version as Superseded so that I don't
> accidentally take the wrong version.
> 
> In the title "wifi:" is missing but I can add that during commit.
> 

Awesome. :)

Thanks, Kalle!
--
Gustavo
