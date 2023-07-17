Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188367562AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjGQMYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjGQMYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:24:49 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC95D8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:24:47 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id CD3A7D5D;
        Mon, 17 Jul 2023 14:24:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1689596685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=547siJi3t85Xcz6ojSNfoOo4b9G05DxMLnvPU7f9uqg=;
        b=i2E1Hg6bvB2aEIHHkaSipJ/d96HxQwbxf+t9dOTGuXGrsXdlgcWRklfiKSTFRq4sNZAxsx
        xoUwopAHWv+PKNVeqFkZd9/tMact/MUjj4GRfQ1Qvnl0kb3T2O9ImExk2Y/hDYztlsklIr
        AtZUCH7xG9lG+FsCMM3MWAFC6YIvpLRjpsfbe/jrF1Brif5d7VmSqWgxMrzBh5FCoB1/s1
        4L+8HscYqqPvGN1dsANQT8KqzKVpDe5jOtS3j+8wbO1f5DM1U48CNklUujWf9ft0ZTLypd
        dXzdi02ubd4GAVF4vS8dAvsUj3g+kJhp+xSu1D4u3o0qpwNKuGj4WzeQl+QIhg==
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 14:24:45 +0200
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v6 3/3] nvmem: core: Expose cells through sysfs
In-Reply-To: <20230717075147.43326-4-miquel.raynal@bootlin.com>
References: <20230717075147.43326-1-miquel.raynal@bootlin.com>
 <20230717075147.43326-4-miquel.raynal@bootlin.com>
Message-ID: <f85f117a59586dc2e5df33e11b39c69f@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> There is one limitation though: if a layout is built as a module but is
> not properly installed in the system and loaded manually with insmod
> while the nvmem device driver was built-in, the cells won't appear in
> sysfs. But if done like that, the cells won't be usable by the built-in
> kernel drivers anyway.

What is the difference between manual loading with insmod and automatic
module loading? Or is the limitation, layout as M and device driver as Y
doesn't work?

-michael
