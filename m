Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFCD783B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjHVIJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjHVIJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:09:28 -0400
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [178.154.239.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8631A1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:09:24 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:6284:0:640:e19:0])
        by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 73B3A5FBF5;
        Tue, 22 Aug 2023 11:09:12 +0300 (MSK)
Received: from [IPV6:2a02:6b8:82:604:f7ab:b25b:2f4e:2225] (unknown [2a02:6b8:82:604:f7ab:b25b:2f4e:2225])
        by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id A9Ew2M1OmmI0-cjy0p2qI;
        Tue, 22 Aug 2023 11:09:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1692691751; bh=cfrCuihVdIjSSCX3tJvpKT0CUSE5WyBwGjjq0fXTL64=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=wdC+yzd1wdT4Q0wJXTyUbYGQAU+riYEF7Y7+c6AjdfgFFmN/ggbDz2vCp9N+558s1
         p2YWad6f/Qk16sMlc/OG3pyE1pIvtJMUsluuyQqr/NzxhExoJSW/1peoDIlgiTEe2M
         gCE9YDOkbjGAxvFB4Scu2x895ivPhRga1PDqUcxg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <aa7e2363-05de-8e7e-74f3-eb7f8b276bf6@yandex-team.ru>
Date:   Tue, 22 Aug 2023 13:09:09 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RESEND PATCH v2 2/2] PCI: implement custom llseek method for PCI
 resource entries in sysfs
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230821072956.114193-2-valesini@yandex-team.ru>
 <202308220648.wcmc5jWq-lkp@intel.com>
From:   Valentin Sinitsyn <valesini@yandex-team.ru>
In-Reply-To: <202308220648.wcmc5jWq-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.2023 04:15, kernel test robot wrote:
> Hi Valentine,
> 
> kernel test robot noticed the following build errors:
Just realized that v3 doesn't really address this, will send the updated 
patch shortly.

Best,
Valentin
