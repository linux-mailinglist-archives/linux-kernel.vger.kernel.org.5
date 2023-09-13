Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDA879EF44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjIMQsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjIMQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:48:11 -0400
Received: from smtp108.ord1d.emailsrvr.com (smtp108.ord1d.emailsrvr.com [184.106.54.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDB130F6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1694623615;
        bh=mpmutqwDGvLifxJSup8XZD/+BDZpRh9Z1PozwFPv+xs=;
        h=Date:Subject:To:From:From;
        b=SSTWsb4fo/GvJJk/3Uht3MjrJasta6IsxH3lGP2f6tDcVJtLrEesDcaCRwsgu+wu8
         BaIpBsoOO1rZCuPBLy8t0HTodGND3E1dmeIaTHbBIv4ZtzTLC5NVjQ4QFZY5A6TzVV
         AWXsY7pEFyZ3XUrrTujMUNK0YkJ4JFtuYI3nJ+XI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 6926FE00B0;
        Wed, 13 Sep 2023 12:46:54 -0400 (EDT)
Message-ID: <9c8be475-a0a4-4968-9457-b9d697ae8c95@mev.co.uk>
Date:   Wed, 13 Sep 2023 17:46:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] comedi: comedi_8254: Conditionally remove I/O
 port support
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <Message-Id: <20230913113247.91749-1-abbotti@mev.co.uk>
 <20230913164013.107520-1-abbotti@mev.co.uk>
 <20230913164013.107520-5-abbotti@mev.co.uk>
Content-Language: en-GB
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20230913164013.107520-5-abbotti@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: d310c078-7e02-4c7e-9722-148a59b1a517-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 17:40, Ian Abbott wrote:
> The comedi_8254 module supports both port I/O and memory-mapped I/O.
> In a future patch, the port I/O functions (`inb()`, `outb()`, and
> friends) will only be declared if the `HAS_IOPORT` configuration option
> is enabled.
> 
> Conditionally compile the parts of the module that use port I/O so they
> are compiled if and only if the `CONFIG_HAS_IOPORT` macro is defined, so
> that it can still be built if the port I/O functions have not been
> declared.  If `CONFIG_HAS_IOPORT` is undefined, replace the GPL-exported
> `comedi_8254_io_alloc()` function with a dummy static inline version
> that just returns `ERR_PTR(-ENXIO)`.
> 
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> v2: N/A
> ---

Oops. I forgot the --- dividing line before the patch change log.  (Same 
mistake in patches 06 and 09.  Time for a v3.  Sorry about that.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

