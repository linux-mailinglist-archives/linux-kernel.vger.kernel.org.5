Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92147EEC13
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 06:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjKQFtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 00:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQFtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 00:49:09 -0500
X-Greylist: delayed 863 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Nov 2023 21:49:05 PST
Received: from mail.oetec.com (mail.oetec.com [108.160.241.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8A21A5;
        Thu, 16 Nov 2023 21:49:05 -0800 (PST)
Received: from [172.16.35.9] (cpe8c6a8d4d360a-cm8c6a8d4d3608.cpe.net.cable.rogers.com [99.253.151.152])
        (authenticated bits=0)
        by mail.oetec.com (8.17.1/8.16.1) with ESMTPSA id 3AH5YCpU064107
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Fri, 17 Nov 2023 00:34:13 -0500 (EST)
        (envelope-from dclarke@blastwave.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=blastwave.org;
        s=default; t=1700199254;
        bh=PvIxctXLgaHgk2d2RaUgrIbNlEUE181R8LoHySAcYCY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mI0DHJEA7W0nohOYB1QCRNdDzlCjLAe3aG2MIeeokSWKRVu6WOeUtRALp1qMZCXuC
         rbDmk12wtHpzrTzieH1101Au1Zg2HgLXX7P8exdi8rgIECqbkwgURnnVgP+sOlokZf
         /AGCZE5075eMq7qnvuyhihaLl6W7+HBhuEUjApIltaOijvg8O6qUKHB4ELsxLUIOO+
         oCZfgKYMl0+KpkVNEYIJuJC32QQ/B+XpZzuqrwDTLOu1NeZbRrN2wSiKBbhDUduE6F
         hHxEd0zuqut0eLvX8GYH6lSWe3UGjv7yK5M/9+siUly4ZdsIAvsVTOmIrdjH7njsH8
         rmZ+xpRJg00uA==
Message-ID: <e110cfff-08f9-4bbc-6b69-0d67ae6562b6@blastwave.org>
Date:   Fri, 17 Nov 2023 00:34:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: =?UTF-8?Q?Re=3a_Fwd=3a_sign-file=2ec=3a149=3a17=3a_warning=3a_impli?=
 =?UTF-8?Q?cit_declaration_of_function_=e2=80=98ENGINE=5fload=5fbuiltin=5fen?=
 =?UTF-8?B?Z2luZXPigJk=?=
Content-Language: en-CA
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Kernel Keyrings <keyrings@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <1fca50c4-6d7b-4c9b-bcea-4df17e2c2e7e@gmail.com>
From:   Dennis Clarke <dclarke@blastwave.org>
Organization: GENUNIX
In-Reply-To: <1fca50c4-6d7b-4c9b-bcea-4df17e2c2e7e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-oetec-MailScanner-Information: Please contact the ISP for more information
X-oetec-MailScanner-ID: 3AH5YCpU064107
X-oetec-MailScanner: Found to be clean
X-oetec-MailScanner-From: dclarke@blastwave.org
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 18:41, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a bug report on Bugzilla [1]. Quoting from it:
> 
<snip>
>> Not related to https://bugzilla.kernel.org/show_bug.cgi?id=215750 but I *feel* that
>> this code needs a hug.
> 
> See Bugzilla for the full thread.
> 
> AFAIK, this looks like a bug when the kernel is compiled against custom
> (non-system) version of OpenSSL library.
> 

I do not know what you could possibly mean. There is nothing "custom"
about OpenSSL. For that matter the gcc compiler I am using was also
built by me. Works fine. The sign-file.c source compiles fine.

It fails to compile in the usual way when trying to build the kernel.

Dennis
