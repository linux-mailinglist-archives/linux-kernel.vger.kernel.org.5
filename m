Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375A57B5E59
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbjJCArQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjJCArP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:47:15 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87588B0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696294032; x=1727830032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lJHTEeIMXcxkw0tGC0S2zg/ltb6YUncf/rwBUz7axpY=;
  b=VJr/8jHO/pPayjfJKBCBVYxyOSxXIIvlkc2IHEU0qXVkbCuqWQuzlRTH
   dm4CtZhBesWLDsA6U6UhWwdcfnToli2h7hBYhi1BP53e+VrT6LjxL5pZ5
   Et9YZWapObno/k6WxLLArpuL6Y4Ufbrep0vJ51H79NpzGzbmZEwad4aKi
   /wbhuqtbj3tS0QKnWTqJLZzvxo/FAqWsCXKmaXr+r67vvH1dPYz5OXrq2
   9ARkl9BAL5aN7D7Wu3pn592G1ZVluJMOh+Z4+hQ63GtCAUQ+jcA5muAlS
   X+TXDX7EUkjx0Kev1P2mAaTXGOUeVora5k/LKJMf99BQVq4Lmk3wvfgh/
   Q==;
X-CSE-ConnectionGUID: td9T6VWfQheQitFxt/Hgxg==
X-CSE-MsgGUID: hb2Ulx9fRcmu8+1GxmDgRw==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="245837821"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2023 08:47:10 +0800
IronPort-SDR: EXxhgdPwddF8J3QhdRJ43v3nGvreaE6AFLdwvTWZcOva18QZNEU3q+kS7PYo7q+pGUgUf66yfB
 H8lnhdm26bFlCD0z/XV4TmzsjXuNXbYATJ85UEsu61C9z8IAfGreJRIOlTMKKoQigyjJIInTk4
 aGfbDvQVyppXe/AOW2XFWNgcMstErSwpcgwQLYMJjk2geY3I8P1EP2UzGLLDVpQguDTc93I/DA
 UnGuBAD8YtA9MVGwkXITdBbe/sbZNlZf1JVRCxZRFwIkSpcN/XCD7Pfj7TH/+/4Pa/mZ9Qc7Zu
 s2E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2023 16:59:31 -0700
IronPort-SDR: DXVpkzJgpMRXz5qOt087GFDJeEQvp/8tO4au/A6WVrS0uIYkfP8DXXRdFu15Pwijdy6JmLIAw7
 D1VmZcLFRLjN0hCxa0PTEMdjEy+0wZl9uFvXY+bJwPYQxcnm6Xf7Q94hMp2GOL/lU8djpfl1Fw
 IMUU+GXTaoeP2Il5PwflDx0GA6Mo9Jku24ug6LeaBDeI4YqujZi1G0SxB9x5RX6YgF5IN1eNUE
 xUbpL36rwcE6s6YsROqAWTzaP7CjukesmKtQopjTtI8edChqVubA/1LXrqHxaHd2vDYAdsgZuk
 HVM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2023 17:47:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Rzzg25tDFz1RtVN
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:47:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1696294015; x=1698886016; bh=lJHTEeIMXcxkw0tGC0S2zg/ltb6YUncf/rw
        BUz7axpY=; b=Kv4E6J6kqsFFGkhgFVKpmvuItG2QFJDEgJD8w78gVTHvj+s/UUw
        wCK2eqD5+sJ6vScMMiIxmti3vVRLi6RthORz08kCPfUL0+0enMoD0uoNm87cNB5D
        taoJjhD1sYGdUdGFVB27LuJX18OQmsD05qgiSZFPDbEnOn8ymW9plTM2nx7aOyet
        34ZFnR0WR8z9/kA4cJ5YgIZHEf+vc1MgX7B8dg4SU1eZe0gilWd6KnD/4JJVibZ1
        1g2dNXIU2qIq/UaW2vc1u9CzjaV30yppFIHkuT0KEVRwWy4cwo9oqVFZ/Sp1N7+R
        x/JBFxUd0MdlHLXU9U7kFiQK31sjpez9xXg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WBXQ7IKY2fdF for <linux-kernel@vger.kernel.org>;
        Mon,  2 Oct 2023 17:46:55 -0700 (PDT)
Received: from [10.225.163.119] (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Rzzfl1YBfz1RtVG;
        Mon,  2 Oct 2023 17:46:54 -0700 (PDT)
Message-ID: <5d208a9d-1bdc-57a3-1a1d-1b84796a2573@opensource.wdc.com>
Date:   Tue, 3 Oct 2023 09:46:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: linux-next: duplicate patches in the libata tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231003080744.69ca4ed0@canb.auug.org.au>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20231003080744.69ca4ed0@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 06:07, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   0e23330fccd4 ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
>   1cf14228f460 ("scsi: sd: Differentiate system and runtime start/stop management")
>   540bd522a82e ("ata: libata-scsi: link ata port and scsi device")
>   54e5c956a103 ("scsi: sd: Do not issue commands to suspended disks on shutdown")
>   6d62f34a6741 ("ata: libata-core: Fix ata_port_request_pm() locking")
>   7c412cfbeecf ("scsi: Do not attempt to rescan suspended devices")
>   9459518aba7b ("ata: libata-scsi: Fix delayed scsi_rescan_device() execution")
>   cb37013b985e ("ata: libata-eh: Fix compilation warning in ata_eh_link_report()")
>   e4bfeedb3b50 ("ata: libata-core: Fix port and device removal")
>   f215cc816f8f ("ata: libata-core: Do not register PM operations for SAS ports")
>   fdd57890e769 ("ata: libata-core: Fix compilation warning in ata_dev_config_ncq()")
> 

Stephen,

Now fixed. Apologies about the noise.

-- 
Damien Le Moal
Western Digital Research

