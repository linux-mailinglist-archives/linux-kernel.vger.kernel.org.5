Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A3875D5F4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGUUsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGUUsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:48:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC4130E2;
        Fri, 21 Jul 2023 13:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=pPiT0nNC4yMJYFJN2WXxCYRGy4DbhNU+d1P34vtAgyk=; b=FWmeRKS65dQdZHKeV7ZDq8W7Zw
        zIyV0iqawLDivnEwU1jfsv9A/8JBw9ibISpUZju7SR/zTwOClyAxgPJ4kBrbCUVhcvkJjQVSWnVzn
        A6uPFQvwM88H6feTfA4iJTyj9nzdEHF5j7EvrkvgYueQ6ldjMowTu3HrroOhBK26KmQ5hxfExInc0
        ExvIxWju8aNE6o2lBrnhwXwE1cztXIJzrURGDXxZZmcSp9NOgpFuOquqTN3OLkAPPakb9jGKPuRkS
        Dn9T3LCpM8z87Vgxzkm6LvrWpnZLxF7/mbZS/EwgM8PlCdPwGzBNwMxrNa8tKS+oBKeLdfex8YA1i
        ZJxDl8Pw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMx3E-00F5Cu-2a;
        Fri, 21 Jul 2023 20:48:36 +0000
Message-ID: <db709099-a2aa-c03f-61bb-6130adfd6f4a@infradead.org>
Date:   Fri, 21 Jul 2023 13:48:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/8] iio: core: Fix issues and style of the comments
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
 <20230721170022.3461-7-andriy.shevchenko@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230721170022.3461-7-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/23 10:00, Andy Shevchenko wrote:
> The `scripts/kernel-doc -v -none -Wall` reports several issues
> with the kernel doc in IIO core C file. Update the comments
> accordingly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 57 +++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 66cea23df7e0..a9b9804097ab 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c

> @@ -594,7 +608,7 @@ EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
>   * If device is assigned no mounting matrix property, a default 3x3 identity
>   * matrix will be filled in.
>   *
> - * Return: 0 if success, or a negative error code on failure.
> + * Returns: 0 if success, or a negative error code on failure.
>   */
>  int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix)
>  {

> @@ -1750,7 +1767,7 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
>   * @inode:	Inode structure pointer for the char device
>   * @filp:	File structure pointer for the char device
>   *
> - * Return: 0 for successful release
> + * Returns: 0 for successful release.
>   */

As documented in Documentation/doc-guide/kernel-doc.rst:
  The return value, if any, should be described in a dedicated section
  named ``Return``.

However, as you (and I) have found, "Returns:" also works as a section name.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy
