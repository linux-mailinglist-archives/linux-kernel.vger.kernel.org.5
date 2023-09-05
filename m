Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDEE792EC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbjIETTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242732AbjIETTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:19:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2DBCF6;
        Tue,  5 Sep 2023 12:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693941563; x=1725477563;
  h=message-id:date:mime-version:subject:from:to:references:
   in-reply-to;
  bh=eCDMOyICFyszfGdAVFtDi08TZeaXnO9zo414HDlPeHY=;
  b=fX/CNG7pauoaY1TnYUvxfDIENPuX7RJ+ul+BKSyy8ng65b3sr422y8g2
   64O/P3Bw90MNz+9dJpikc7gJga2QZUepAUDi2Xacib6G6RkqN+r1qN8aC
   YNgqVYMUsj7olcD2FebKPdL6mbxATgk/IhGqpcUzLMmQnychztaD1Oq8p
   /fwe3Qx32E9el2lNTYw0aC7bgEhSx7fUcKI6DCeBrePxngz9lwjtVQOYY
   AreGCBVav7HOdT7k99DWwjkR56sHzH+x787nQpJP8VRS2IQ6bqq/YqTxm
   nOU7Birjpg0oStJbguXOTX85ZXa0zszQaSDTWPZwbFKXe9ZGK1QSQTd1N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="376801812"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="376801812"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 12:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="806718995"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="806718995"
Received: from gedouard-mobl1.amr.corp.intel.com (HELO [10.212.174.92]) ([10.212.174.92])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 12:16:36 -0700
Content-Type: multipart/mixed; boundary="------------Ra3002NBvylt7RDwgJaw62gw"
Message-ID: <911a3e8f-7adf-6089-6651-1f847e4edce6@intel.com>
Date:   Tue, 5 Sep 2023 12:16:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: ucsi debugfs oops (current Linus pre-6.6-rc1)
From:   Dave Hansen <dave.hansen@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saranya Gopal <saranya.gopal@intel.com>,
        Rajaram Regupathy <rajaram.regupathy@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Wayne Chang <waynec@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-usb@vger.kernel.org
References: <700df3c4-2f6c-85f9-6c61-065bc5b2db3a@intel.com>
Content-Language: en-US
In-Reply-To: <700df3c4-2f6c-85f9-6c61-065bc5b2db3a@intel.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------Ra3002NBvylt7RDwgJaw62gw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/23 12:10, Dave Hansen wrote:
> I'm having some problems booting Linus's current tree.  It seems to have
> happened in some content between commit 3f86ed6ec0b3 and df0383ffad.
> 
> I'm suspecting this commit:
> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df0383ffad64dc09954a60873c1e202b47f08d90

The attached patch works around the problem for me and at least lets me
get booting again.  I do see this in dmesg (from my patch):

[    7.818203] no ucsi->debugfs

--------------Ra3002NBvylt7RDwgJaw62gw
Content-Type: text/x-patch; charset=UTF-8; name="sillydebug.patch"
Content-Disposition: attachment; filename="sillydebug.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3R5cGVjL3Vjc2kvZGVidWdmcy5jIGIvZHJpdmVy
cy91c2IvdHlwZWMvdWNzaS9kZWJ1Z2ZzLmMKaW5kZXggMGM3YmY4OGQ0YTdmLi5mOTlkODQx
NjVmM2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL3R5cGVjL3Vjc2kvZGVidWdmcy5jCisr
KyBiL2RyaXZlcnMvdXNiL3R5cGVjL3Vjc2kvZGVidWdmcy5jCkBAIC04NCw2ICs4NCwxNCBA
QCB2b2lkIHVjc2lfZGVidWdmc19yZWdpc3RlcihzdHJ1Y3QgdWNzaSAqdWNzaSkKIAogdm9p
ZCB1Y3NpX2RlYnVnZnNfdW5yZWdpc3RlcihzdHJ1Y3QgdWNzaSAqdWNzaSkKIHsKKwlpZiAo
IXVjc2kpIHsKKwkJcHJpbnRrKCJubyB1Y3NpIik7CisJCXJldHVybjsKKwl9CisJaWYgKCF1
Y3NpLT5kZWJ1Z2ZzKSB7CisJCXByaW50aygibm8gdWNzaS0+ZGVidWdmcyIpOworCQlyZXR1
cm47CisJfQogCWRlYnVnZnNfcmVtb3ZlX3JlY3Vyc2l2ZSh1Y3NpLT5kZWJ1Z2ZzLT5kZW50
cnkpOwogCWtmcmVlKHVjc2ktPmRlYnVnZnMpOwogfQo=

--------------Ra3002NBvylt7RDwgJaw62gw--
