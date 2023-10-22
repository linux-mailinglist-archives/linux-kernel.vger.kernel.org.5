Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501897D211B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 07:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjJVFLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 01:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVFLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 01:11:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2E8DF;
        Sat, 21 Oct 2023 22:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=LaOSDlCHVRgG4eLBoNpIRzvo1mfgD+GAe0lAq4bGIO0=; b=rk+e68BoAezYXyP7eUCajyejDp
        4mo+UmVj3QYTd/Z+n2u+Gl2mokYB4kOBYNUe8Ht5E6kwhUUAPRjXDY8LHwFTJUIYNEawk4YvkbfHA
        wBoBdL9ev60YZ613CTXqGI6C5+tD57rOaaEuCCv/4mO/WtJkcyaYI/igK9txekZJEaPJZHpQHAYE2
        7z7su7PTxSVYvQ9nDFyWAVZTr7vTfdz6YsdWTpFVipQkaq1fBlfO6tbzS1KKRKw79nXAZsUsR/LEZ
        l8dVVvlc2j8fDFZv7dqXa0JywW8NRGOOabUb122YIYmlM3qhbgbLCaDLr7L3l5OFz0OPAXA2jItDM
        kGjOEO1A==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1quQjt-004skb-0h;
        Sun, 22 Oct 2023 05:11:03 +0000
Message-ID: <a05b46db-260f-4ba9-b335-4d8cd14292e2@infradead.org>
Date:   Sat, 21 Oct 2023 22:10:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel panic after booting custom kernel [hyperv message]
Content-Language: en-US
To:     gmssixty gmssixty <gmssixty@gmail.com>,
        linux-kernel@vger.kernel.org,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <CAOx-CDU4_3j-mQcczscZ-xqq+XF7R=H62i1SoojczG8WELUMgQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAOx-CDU4_3j-mQcczscZ-xqq+XF7R=H62i1SoojczG8WELUMgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-hyperv mailing list]


On 10/21/23 22:05, gmssixty gmssixty wrote:
> I have compiled kernel-6.4.12 from source. I have put the bzImage in
> /dev/sda3/boot. Booted it. I am on virtualbox. After booting got this
> message:
> 
> Kernel panic - not syncing: XSAVE has to be disabled as it is not
> supported by this module
> 

The next line should say:

	Please add 'noxsave' to the kernel command line.

That's one (maybe temporary) solution.

> Note that, no other software has been installed in /dev/sda3. I am
> trying to boot custom linux kernel.
> 
> Why did I get this message? What should I do after this?

Do you mean to be using hyperv?
Do hyperv and virtualbox mix well?

You should post your full custom .config file.

-- 
~Randy
