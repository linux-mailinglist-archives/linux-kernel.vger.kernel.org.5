Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294007AF07C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjIZQTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjIZQTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:19:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A84EB;
        Tue, 26 Sep 2023 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695745140; x=1727281140;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ATDp29asW+amdSOP7sAM78HFxFX7RJ83JjLVpk3qsZQ=;
  b=Cn1x8242qmUWQoyOkWveP/7ZRsvk3NivNPe6yC2rwrazDa1ZDlhbj2GE
   Enl/dXEjSxhjHaikYQTDHgTUaF/bAGRPaSDibn50F2xL91Bu+MN4V3faI
   Vl9q7J3HEE7t2s06sZSy6xqhNcykQGqX8YF983q/JkGRMFOYGHJBFLqcB
   LeIqc8EqkH/lCup6co82JUEzRR+yFtg103aGN1tDiN6B6taiCjXbO9sbf
   InvY9vFuKI8SoDSWFC2KmPxiA1Q0QY6cQdm0Vzihwh9FOGBZy0xx//cjK
   iEa4YNW27drKSnYgRt3pvZJ09EXdmA8gEopnlMTPHxZ+ucF59dcLYlIcx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378884817"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378884817"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="995854941"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="995854941"
Received: from hhalmen-mobl.ger.corp.intel.com ([10.251.219.207])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:18:56 -0700
Date:   Tue, 26 Sep 2023 19:18:53 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Liming Sun <lsun@mellanox.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/mellanox: tmfifo: fix kernel-doc warnings
In-Reply-To: <20230926054013.11450-1-rdunlap@infradead.org>
Message-ID: <7b57bf9d-b024-b435-54ca-6ab5916197a1@linux.intel.com>
References: <20230926054013.11450-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2105164461-1695745138=:1894"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2105164461-1695745138=:1894
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 25 Sep 2023, Randy Dunlap wrote:

> Fix kernel-doc notation for structs and struct members to prevent
> these warnings:
> 
> mlxbf-tmfifo.c:73: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_vring '
> mlxbf-tmfifo.c:128: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_vdev '
> mlxbf-tmfifo.c:146: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_irq_info '
> mlxbf-tmfifo.c:158: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_io '
> mlxbf-tmfifo.c:182: warning: cannot understand function prototype: 'struct mlxbf_tmfifo '
> mlxbf-tmfifo.c:208: warning: cannot understand function prototype: 'struct mlxbf_tmfifo_msg_hdr '
> mlxbf-tmfifo.c:138: warning: Function parameter or member 'config' not described in 'mlxbf_tmfifo_vdev'
> mlxbf-tmfifo.c:212: warning: Function parameter or member 'unused' not described in 'mlxbf_tmfifo_msg_hdr'
> 
> Fixes: 1357dfd7261f ("platform/mellanox: Add TmFifo driver for Mellanox BlueField Soc")
> Fixes: bc05ea63b394 ("platform/mellanox: Add BlueField-3 support in the tmfifo driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: lore.kernel.org/r/202309252330.saRU491h-lkp@intel.com
> Cc: Liming Sun <lsun@mellanox.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: Vadim Pasternak <vadimp@nvidia.com>
> Cc: platform-driver-x86@vger.kernel.org
> ---
>  drivers/platform/mellanox/mlxbf-tmfifo.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff -- a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -53,7 +53,7 @@
>  struct mlxbf_tmfifo;
>  
>  /**
> - * mlxbf_tmfifo_vring - Structure of the TmFifo virtual ring
> + * struct mlxbf_tmfifo_vring - Structure of the TmFifo virtual ring
>   * @va: virtual address of the ring
>   * @dma: dma address of the ring
>   * @vq: pointer to the virtio virtqueue
> @@ -113,12 +113,13 @@ enum {
>  };
>  
>  /**
> - * mlxbf_tmfifo_vdev - Structure of the TmFifo virtual device
> + * struct mlxbf_tmfifo_vdev - Structure of the TmFifo virtual device
>   * @vdev: virtio device, in which the vdev.id.device field has the
>   *        VIRTIO_ID_xxx id to distinguish the virtual device.
>   * @status: status of the device
>   * @features: supported features of the device
>   * @vrings: array of tmfifo vrings of this device
> + * @config: non-anonymous union for cons and net

I wonder what information this adds? It's not documenting anything else 
than C syntax, IMO.

Would it be possible to make kerneldoc not give warning from a named union 
which is already fully documented?

-- 
 i.

>   * @config.cons: virtual console config -
>   *               select if vdev.id.device is VIRTIO_ID_CONSOLE
>   * @config.net: virtual network config -
> @@ -138,7 +139,7 @@ struct mlxbf_tmfifo_vdev {
>  };
>  
>  /**
> - * mlxbf_tmfifo_irq_info - Structure of the interrupt information
> + * struct mlxbf_tmfifo_irq_info - Structure of the interrupt information
>   * @fifo: pointer to the tmfifo structure
>   * @irq: interrupt number
>   * @index: index into the interrupt array
> @@ -150,7 +151,7 @@ struct mlxbf_tmfifo_irq_info {
>  };
>  
>  /**
> - * mlxbf_tmfifo_io - Structure of the TmFifo IO resource (for both rx & tx)
> + * struct mlxbf_tmfifo_io - Structure of the TmFifo IO resource (for both rx & tx)
>   * @ctl: control register offset (TMFIFO_RX_CTL / TMFIFO_TX_CTL)
>   * @sts: status register offset (TMFIFO_RX_STS / TMFIFO_TX_STS)
>   * @data: data register offset (TMFIFO_RX_DATA / TMFIFO_TX_DATA)
> @@ -162,7 +163,7 @@ struct mlxbf_tmfifo_io {
>  };
>  
>  /**
> - * mlxbf_tmfifo - Structure of the TmFifo
> + * struct mlxbf_tmfifo - Structure of the TmFifo
>   * @vdev: array of the virtual devices running over the TmFifo
>   * @lock: lock to protect the TmFifo access
>   * @res0: mapped resource block 0
> @@ -198,7 +199,7 @@ struct mlxbf_tmfifo {
>  };
>  
>  /**
> - * mlxbf_tmfifo_msg_hdr - Structure of the TmFifo message header
> + * struct mlxbf_tmfifo_msg_hdr - Structure of the TmFifo message header
>   * @type: message type
>   * @len: payload length in network byte order. Messages sent into the FIFO
>   *       will be read by the other side as data stream in the same byte order.
> @@ -208,6 +209,7 @@ struct mlxbf_tmfifo {
>  struct mlxbf_tmfifo_msg_hdr {
>  	u8 type;
>  	__be16 len;
> +	/* private: */
>  	u8 unused[5];
>  } __packed __aligned(sizeof(u64));
>  
> 
--8323329-2105164461-1695745138=:1894--
