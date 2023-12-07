Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C354580921E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443885AbjLGUP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjLGUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:15:54 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB541710;
        Thu,  7 Dec 2023 12:16:00 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6d9d1962bbbso884264a34.3;
        Thu, 07 Dec 2023 12:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701980160; x=1702584960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cQkDdnzepc6At1PDW9suBRg6vKVDLjVoo/BJeFLK1g=;
        b=Sd4rwBwKEW9DkhWkoNcxrhM+uHT3ZpKc2za/ehgHYyYH8cBStbtPZUZs8827KinQa2
         VBQrxhS58zzzCzAtVG0haU8YvR6qinqxdEFKr9iq7qPNzJmZpIv/CVxRb9ho1HCNZ/Qw
         /KnG2NKj9OWQsXd9Bm2SLoK/3BJcQ3UkS7D50Na0DMLmLSjDEDx9DDX1bf1Zd0dn6RYT
         JW8p9twOlof6r6bnjx1BzByFIm/RQrCStEJMEMbjpIoY6eSAyjgVRS5YmRKN7PQ2JpIK
         pEONR7zi4mYb+2oFeHU6NGY2eneQZvg4pk0XGIVp74TDJXaQZobrx4Og/h19EQy0X8t/
         6LYA==
X-Gm-Message-State: AOJu0Yz9RTuRPycT3sRYtbtqr30YkHI+Lh/f4mKr+9emrTsi85qsG0En
        6mq6lrrurVl6X8OEfYNSWV6fFMnQag==
X-Google-Smtp-Source: AGHT+IFa/J/UWM9ONWck/IBcMt0yTQGD1q3vexfwZIVq0OcVUIh+Jxedgy1LdSaEjeGZFUduSZ6QrA==
X-Received: by 2002:a9d:6d85:0:b0:6d8:7ffc:d878 with SMTP id x5-20020a9d6d85000000b006d87ffcd878mr2821370otp.16.1701980160090;
        Thu, 07 Dec 2023 12:16:00 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r17-20020a056830135100b006d98106678esm83811otq.18.2023.12.07.12.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:15:59 -0800 (PST)
Received: (nullmailer pid 3350935 invoked by uid 1000);
        Thu, 07 Dec 2023 20:15:58 -0000
Date:   Thu, 7 Dec 2023 14:15:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 4/4] powerpc: Stop using of_root
Message-ID: <20231207201558.GB3348285-robh@kernel.org>
References: <e6cf01d41502b15e688b6f5aa5c3b68c62b8ac64.1701878821.git.christophe.leroy@csgroup.eu>
 <b2f23f982ef414f0eaf7c55ccb79f30bec3c86cd.1701878821.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2f23f982ef414f0eaf7c55ccb79f30bec3c86cd.1701878821.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:13:35PM +0100, Christophe Leroy wrote:
> Replace all usages of of_root by of_find_node_by_path("/")
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/secure_boot.c        |  8 ++++++--
>  arch/powerpc/kexec/ranges.c              |  8 +++++---
>  arch/powerpc/mm/drmem.c                  | 10 +++++-----
>  arch/powerpc/mm/numa.c                   |  6 ++++--
>  arch/powerpc/platforms/52xx/efika.c      |  4 +++-
>  arch/powerpc/platforms/pasemi/pci.c      |  4 +++-
>  arch/powerpc/platforms/pseries/lparcfg.c |  6 +++++-
>  arch/powerpc/platforms/pseries/setup.c   | 12 +++++++++---
>  8 files changed, 40 insertions(+), 18 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
