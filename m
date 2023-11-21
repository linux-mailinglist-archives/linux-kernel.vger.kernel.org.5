Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620177F2E34
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjKUNZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjKUNZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:25:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8B71BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:25:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E16C433C8;
        Tue, 21 Nov 2023 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700573115;
        bh=5h1dRKlWyHsnS2iAX+ZBjDivjot+UuM0uKEgmm27lSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mb6XfF2Au4nWSAJGBsxKS/vMcj+cqXxZ/8Xau5tFbJUk54vS5AHF5pdMlnBHdjJK0
         FOhcdSvbpwK3y7lfPGWA4fyp+/SHtW5M4eV3eAwpDQyGBYzfZS7zF5t78cRw7HKGMs
         MwKk794GUPEOTmemKRUE3bd6p3wVxAto/VFBFW31qPZN2Zgdr8lhXsD1fCtH7486of
         EtJGrTL3onmt/tZ4jW6Uty6talm+6Wj5EcOMT0jbCB+NTWQ2VWQpWr4EtJLJlJuj0p
         00YVYBlaol8ec2holPUtIDPLpPCI5kmTuvyLQl4+k6D8p/0y60fLZ5RdH4nNysYsXS
         WJdbJToZ/i7KQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r5Qkn-0000u4-1j;
        Tue, 21 Nov 2023 14:25:26 +0100
Date:   Tue, 21 Nov 2023 14:25:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Puliang Lu <puliang.lu@fibocom.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: modify Fibocom to DELL custom modem
 FM101R-GL
Message-ID: <ZVyvxbrCxSos0B6W@hovoldconsulting.com>
References: <20231026123506.26453-1-puliang.lu@fibocom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026123506.26453-1-puliang.lu@fibocom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 08:35:06PM +0800, Puliang Lu wrote:
> Modify the definition of Fibocom USB serial option driver
> FM101R-GL different variants
> 
> - VID:PID 413C:8213, FM101R-GL ESIM are laptop M.2 cards (with
>   MBIM interfaces for Linux)
> 
> - VID:PID 413C:8215, FM101R-GL are laptop M.2 cards (with
>   MBIM interface for Linux)
> 
> 0x8213: mbim, tty
> 0x8215: mbim, tty
> 
> Signed-off-by: Puliang Lu <puliang.lu@fibocom.com>
 
> -#define DELL_PRODUCT_FM101R			0x8213
> -#define DELL_PRODUCT_FM101R_ESIM		0x8215
> +#define DELL_PRODUCT_FM101R_ESIM		0x8213
> +#define DELL_PRODUCT_FM101R				0x8215

You have an extra tab here so that the values are no longer aligned.

>  
>  #define KYOCERA_VENDOR_ID			0x0c88
>  #define KYOCERA_PRODUCT_KPC650			0x17da

Now applied with a slightly updated commit message:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-linus&id=a1092619dd28ac0fcf23016160a2fdccd98ef935

Johan
