Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1FB7C4AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345453AbjJKGjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbjJKGjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:39:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333FC93;
        Tue, 10 Oct 2023 23:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8g0oB6PqYhngbYuG23JzqWL+yNnX6VYd4fp4Ba0ALOs=; b=2YJhSVXBo8Hk70GbN+zRFplRIN
        zGM21InwXmWArCXhd6WswAcoReAVxVvlwJ7NXF30XHrAB5aCuveXrDfLq+O2AGQFjTQ60EI1QfkfE
        CPpx0B01ZeFlN8KrRpdwEQwYij4VBUBqTbIMUYdeecVOzsjhwh/BtZoFEWVYtKP06IrysbHoGl7H+
        UBvMIdGfh9rBuoCMmlkBeUsyyb1aLycio61slxZ955ihO1btEUu3H2ptWM6vKEUk5/KAHS1oV+CX6
        +24loTi0LvEsEdfbylvD6JbacvJVOwS4k7X7HXUqgaUCzPhy7E+hy/asm2/k0HC0cXefZKQ368Iqc
        kKqpk4qg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqSsC-00F07T-06;
        Wed, 11 Oct 2023 06:39:12 +0000
Date:   Tue, 10 Oct 2023 23:39:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Joey Jiao <quic_jiangenj@quicinc.com>
Cc:     linux-modules@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
Message-ID: <ZSZDEEBDUW5shAtY@infradead.org>
References: <20231009045636.4143-1-quic_jiangenj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009045636.4143-1-quic_jiangenj@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:26:35AM +0530, Joey Jiao wrote:
> When modprobe cmds are executed one by one, the final loaded modules
> are not in fixed sequence as expected.

And why does this matter?

If this is important enough to matter it should just be the default,
and have really good reason for that.  Doing something like this as
a config option does not make any sense.

