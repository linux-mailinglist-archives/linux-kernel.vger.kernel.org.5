Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1361C7F3269
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjKUPfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjKUPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:35:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1917B10C;
        Tue, 21 Nov 2023 07:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700580914; x=1732116914;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0JSxieSjCOIMhhwgkZzxKvnKqrs94/lhtiEaD2XAurk=;
  b=CsqJ8NnihEG9nQdc4YkBtD22vYvM2v3sDz+s9fT2ptZnirWwS11ezEyD
   YtlfVxKy514bdo0GYTyWG6LBqGO4x7GD+rgykNDMY54PmUjOFzIXOpuAG
   +e3nSLzKvQXr0fjzAYyhEtjb3RiNma5dwGN1ZQ48SVbrsBU7JSA5s4DVM
   QGLHtWSeb73Z0E9Md5a82BeM4tZB8Xb328VbpVF8wKQqQxIzWY37iERzS
   o4FQMNdolMlgZnCKpqzFff9+RA/Ptn1FU3Ps7W0HJyfOfVJ8LMldBEcQN
   xIHVperS+YLHRS15YiBLwiDrbrpnrZXkkw9OR4yNGoxd3KAfTEyrFpCFB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="10528844"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="10528844"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:35:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="837079821"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="837079821"
Received: from azanetti-mobl.ger.corp.intel.com ([10.249.46.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:35:10 -0800
Date:   Tue, 21 Nov 2023 17:35:02 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Sterba <dsterba@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jiri Kosina <jikos@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 0/6] tty: remove unused structure members
In-Reply-To: <20231121103626.17772-1-jirislaby@kernel.org>
Message-ID: <fee44985-901b-3b5-3a48-38ba7363e036@linux.intel.com>
References: <20231121103626.17772-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-910341602-1700580912=:2370"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-910341602-1700580912=:2370
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 21 Nov 2023, Jiri Slaby (SUSE) wrote:

> I wrote a little indexer at https://github.com/jirislaby/clang-struct.
> And it found there are few unused structure members inside tty. This
> series removes them.

> Jiri Slaby (SUSE) (6):
>   tty: con3215: drop raw3215_info::ubuffer
>   tty: ipwireless: remove unused ipw_dev::attribute_memory
>   tty: jsm: remove unused members from struct board_ops
>   tty: jsm: remove unused struct jsm_board members
>   tty: rp2: remove unused rp2_uart_port::ignore_rx
>   tty: serial_cs: remove unused struct serial_cfg_mem

For the whole series,

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-910341602-1700580912=:2370--
