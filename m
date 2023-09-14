Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8170A79FAD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjINF2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjINF2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:28:46 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E551A8E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:28:41 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id geu7qi3W7064Kgeu7qSmeo; Thu, 14 Sep 2023 07:28:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694669320;
        bh=e+af5j09RXHijicnoPfch2UIrQzegSr6ZHEjvBLEAIc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=rqPZHfBO5xteKv4Cv1Jt1OblHZxr/1SDkh2R2D7sqGk4eN+eGoTNZ8H5Mkde2bdr4
         8V61wNhUfzN8/odkeDrZ4aRbQEBTfQ0gI5cg2Doy7YtDVZ0j7zMOaX4jC6svTNWSll
         8D3YigKNfkYMQLFWYZZPeBxVm/0Jb1Vw2bMRYRYUYjl24DVNH/3eJpQ6SkoXeY+8oo
         30dVFJxAtzgrKGXoxpGl7ga/+x7gZCY66o9vY0wO1SzbYghS7UdZEn6YJsAXzzg3cr
         vEi6/SVdvNtLTfirYyM+1/6/ejeJXX5olITJw3xhA42S+n9KHHYDJaVLgdMPI3zgLa
         Zop3QRBFwv42w==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Sep 2023 07:28:40 +0200
X-ME-IP: 86.243.2.178
Message-ID: <1d1d83df-c1d1-22b0-72a0-291a68d0c328@wanadoo.fr>
Date:   Thu, 14 Sep 2023 07:28:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] bcachefs: Fix a potential in the error handling path
 of use-after-free inbch2_dev_add()
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcachefs@vger.kernel.org
References: <3ab17a294fd2b5fcb180d44955b0d76a28af11cb.1694623395.git.christophe.jaillet@wanadoo.fr>
 <20230913230135.y27i2bx244tdjhvj@moria.home.lan>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230913230135.y27i2bx244tdjhvj@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 14/09/2023 à 01:01, Kent Overstreet a écrit :
> On Wed, Sep 13, 2023 at 06:44:08PM +0200, Christophe JAILLET wrote:
>> If __bch2_dev_attach_bdev() fails, bch2_dev_free() is called twice.
>> Once here and another time in the error handling path.
>>
>> This leads to several use-after-free.
>>
>> Remove the redundant call and only rely on the error handling path.
> Thanks, both applied



If not too late, it is more a double-free than a use-after-free.

And I messed up the ordering of the words in the subject.

Sorry about that.

CJ

