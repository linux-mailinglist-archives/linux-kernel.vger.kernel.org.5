Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3B17D2804
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjJWBeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjJWBeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:34:08 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1ED30F1;
        Sun, 22 Oct 2023 18:34:05 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id E57BE6047A8EA;
        Mon, 23 Oct 2023 09:33:52 +0800 (CST)
Message-ID: <7f81d365-0440-de01-8be4-9c8d3ab9d69c@nfschina.com>
Date:   Mon, 23 Oct 2023 09:33:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] phy: mapphone-mdm6600: fix an error code problem in
 inv_mpu6050_read_raw
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     jic23@kernel.org, lars@metafoo.de, jean-baptiste.maneyrol@tdk.com,
        chenhuiz@axis.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <20231020165509.00003350@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/20 23:55, Jonathan Cameron wrote:
> What does this have to do with the phy: mapphone-mdm6600?
Oh, really sorry for this. My careless mistake :( .
> I'm not sure why inv_mpu6050_sensor_show() doesn't return
> the actual error code from the regmap_bulk_read() and instead replaces it
> with -EINVAL.  Given you are tidying up this related issues perhaps change
> that as well?
>
> static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
> 				   int axis, int *val)
> {
> 	int ind, result;
> 	__be16 d;
>
> 	ind = (axis - IIO_MOD_X) * 2;
> 	result = regmap_bulk_read(st->map, reg + ind, &d, sizeof(d));
> 	if (result)
> 		return -EINVAL;
> //Make this return result;

Sure, I will tidy up this, Thanks for your suggestion!

Su Hui

