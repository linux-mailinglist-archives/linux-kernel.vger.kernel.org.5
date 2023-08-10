Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD065777BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjHJPOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjHJPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:13:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238762694;
        Thu, 10 Aug 2023 08:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691680424; x=1692285224; i=deller@gmx.de;
 bh=iIkc2RgfKbq4SxDPjebXDccs3vuOZcXYZkuSl/0CCT8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XZPpsXYJ3H20kHWmi/Ad33pJG/4cEU4NDfvR7TckS2UUatPCFPnONvJfVSyPPB6Nxu8sQ2B
 sl5cR3kDYjstqLshcPsb4PxlGmTEMEacToZq+AlE0T4jll0isls+pPq+gMVzPDJDL+p8cI2UO
 j+zq26Q44gCoIsFsMTGHSwQWGv5DHohOYZL03MVND3GmkagZiDDR2k5Yc7if1UD4uDZlS0mp/
 RO+5nlWMACsqvcj/LaP1E/L8GxHySChOPI7uC+O03iFQNLlX1GYCKCj02eXbDXzbn6tcz+Rgi
 MZSnfP7ha768PMdi2InOoxB4u9N3GTZT6gl7yPi8UqJFE7Lig1FQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.133]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59C2-1qT0tY2uHM-00181c; Thu, 10
 Aug 2023 17:13:44 +0200
Message-ID: <398d6094-32c8-71f4-8251-1eec35b460f9@gmx.de>
Date:   Thu, 10 Aug 2023 17:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/17] parport: gsc: mark init function static
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-10-arnd@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230810141947.1236730-10-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yEfK+8nUtFYnsM8Ph91MwYHPqWKUJ56pkaiYxzUUaiLjfkHatuu
 F5JdWoUljJ5vnmLP4D7zo3EpBaWPDRa1Rog6t/fMjiUyPzsCz68FpuKBTB2ZdadWTbJqq2z
 yKpbhKpadf4d+NMe7bL3BuqCqevTUjzjTT7YcCpLhhKbesvpl4bwbq+k0h1K4H7BnzgIZ0r
 yx+DI6WujwXeVNX9E2wtA==
UI-OutboundReport: notjunk:1;M01:P0:/OOZDyjNeIc=;8PkoFez+ICfXtIpQdA+PR//fLeb
 dmFonrvef3qxJZ+FEY4CyUYKwD/aMjGsZktvJ823hcK+fkvPT+1HgFlOgbjz3ezMezJT7fOZg
 ARkzMJtg+KByXnP10/lM3mHnZyTGQULOmTMd6ZY3N+BeVgF2HeHn83ejebX2lf5fAUJl2RNz1
 JtkYQz3OAgZdhJ75tNQDpJNfaWnyhgRRx6WYyU5m3Gr/OY5fMimVtshK1yqVkgbqUwjS3Jdm8
 8AHNwqXYxLnjgcspkssZYjPwxQEK2PZ9734+1WBsjt3eB+5qjr2M/3mvWrVYfVAmS3Oi2XAqi
 Y9BpncPJe2kn3ilFrGOOz9GTcjbSXO1L3WfjvQ9veLhU86ShwfO/F0FKDB5n8SGgYZ6UX27zB
 0FDl5Mvls3sq5FSFscUwxaJM1YrMO1VPjc4Lpska/n15bjMkCbJRw7TfX/fplo5mxg3TGOIll
 fn+0/gwqHX6SAGqoYE/YfHO4/TmSGMuqFRdnoqZL2HfW2mENIXdvKxr/L26FZgRiY4TFy5guV
 pDpW1I86lr8BJRvki+zkV/2vcNjH1c9ZdKI67a+7LTFHA+wH9YUJR9HoFlYE56mW/05cZ1OeS
 cD5L9IOrwH8MCeIKxwzkogdl6V8mK/kljWprHWxUUOkz8vRwGrmVLto9xwoAuHcXKzG7qi7GM
 wMAYE/PtaHx65MihbCe+bIWpbZLx7ijwYNFvxF4XIjz/aagNnnZ1oF4aGnVIUiI94RlMbYWIT
 D0dOePYNh908ljWonQL7gKUKp/GE00v428qPRnIKsmySkdwP44uI25/m8VIGGf9lO7T2LYAEN
 sjChVumXnX4pLXFoJl24q8+kVEwnds614yOu/j5gQf461aZvKnEjOJfhTGAs6oShB3/f85/VW
 WQ5coQnFQIqPpc+lkVF11BfWMqjuh4FR5bOVGFQhA442dKSB4Vhr9NjhwJGj+mFgMuZf2VTS7
 2zMBVqsn8+GXU+U9Epm20qnidq0=
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 16:19, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This is only used locally, so mark it static to avoid a warning:
>
> drivers/parport/parport_gsc.c:395:5: error: no previous prototype for 'p=
arport_gsc_init' [-Werror=3Dmissing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Helge Deller <deller@gmx.de>

