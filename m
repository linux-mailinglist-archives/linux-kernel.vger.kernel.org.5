Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2466275ECB9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGXHqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjGXHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:46:45 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C91E43
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:46:39 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3fa86b08efcso8091935e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690184797; x=1690789597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXQxRuD8J7RHydWYdts0LDcLZy5e3i/QIlpY808Udx4=;
        b=kkHioyGjCBeWh4sH7+zFgcZVBZ7hOBMU7GLS2qeH55Xcl34+lpdzkJFl5bgJTRfx/K
         2nEk9wu2pztnjrZ0PUYAKz67FOVcf5nulRZOpRC9ObjikDMkiUn/W3nXU120AKFGx9nx
         wy2OeXqXN1t7DEXQkTjYzjUi8diKZBWbEzcqiPVdANRzJQ/2WDhUl4b14SWfhb4YyvPn
         B7MHQhLRd1qJ1OAW883JA9naT0DcDEtgADXWoRvvl0lpV67/WYYn+Ir85oUlHYMrgO2e
         O8P5OgvAgjuxbkurijaY8kjKdsH+4b1W+OLKEVwLH/cGNmERa+sIUoZYIwvVssZDLdeZ
         m8fA==
X-Gm-Message-State: ABy/qLa4u+pvapPCymtkjvcY1t4Fmqs6UVoulYYLolX9hmsLUpRQPIJJ
        VUmKvtL5UJWPXN22RCVIHUz0I54HOhI=
X-Google-Smtp-Source: APBJJlHVjb6OjzXn+nznEqYiOlBN2rZAzojWF+Z29xx7p/sURSAURyBJG7EsZwds0jMPqwjYVJQQ1w==
X-Received: by 2002:a05:600c:3b05:b0:3f9:88d:9518 with SMTP id m5-20020a05600c3b0500b003f9088d9518mr7657174wms.0.1690184797014;
        Mon, 24 Jul 2023 00:46:37 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k22-20020a7bc316000000b003fd2d33ea53sm5361223wmj.14.2023.07.24.00.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 00:46:36 -0700 (PDT)
Message-ID: <840cdf34-f38e-ab37-623f-9744c3436350@grimberg.me>
Date:   Mon, 24 Jul 2023 10:46:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: drivers/nvme/host/tcp.c:835:12: warning: stack frame size (2256)
 exceeds limit (2048) in 'nvme_tcp_recv_skb'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Varun Prakash <varun@chelsio.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <202307201141.PYWS6ird-lkp@intel.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <202307201141.PYWS6ird-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/23 06:10, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   bfa3037d828050896ae52f6467b6ca2489ae6fb1
> commit: c2700d2886a87f83f31e0a301de1d2350b52c79b nvme-tcp: send H2CData PDUs based on MAXH2CDATA
> date:   1 year, 5 months ago
> config: riscv-randconfig-r042-20230720 (https://download.01.org/0day-ci/archive/20230720/202307201141.PYWS6ird-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230720/202307201141.PYWS6ird-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307201141.PYWS6ird-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/nvme/host/tcp.c:835:12: warning: stack frame size (2256) exceeds limit (2048) in 'nvme_tcp_recv_skb' [-Wframe-larger-than]
>       835 | static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
>           |            ^
>     1 warning generated.
> 
> 
> vim +/nvme_tcp_recv_skb +835 drivers/nvme/host/tcp.c
> 
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  834
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03 @835  static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  836  			     unsigned int offset, size_t len)
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  837  {
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  838  	struct nvme_tcp_queue *queue = desc->arg.data;
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  839  	size_t consumed = len;
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  840  	int result;
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  841
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  842  	while (len) {
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  843  		switch (nvme_tcp_recv_state(queue)) {
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  844  		case NVME_TCP_RECV_PDU:
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  845  			result = nvme_tcp_recv_pdu(queue, skb, &offset, &len);
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  846  			break;
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  847  		case NVME_TCP_RECV_DATA:
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  848  			result = nvme_tcp_recv_data(queue, skb, &offset, &len);
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  849  			break;
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  850  		case NVME_TCP_RECV_DDGST:
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  851  			result = nvme_tcp_recv_ddgst(queue, skb, &offset, &len);
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  852  			break;
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  853  		default:
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  854  			result = -EFAULT;
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  855  		}
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  856  		if (result) {
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  857  			dev_err(queue->ctrl->ctrl.device,
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  858  				"receive failed:  %d\n", result);
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  859  			queue->rd_enabled = false;
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  860  			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  861  			return result;
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  862  		}
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  863  	}
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  864
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  865  	return consumed;
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  866  }
> 3f2304f8c6d6ed Sagi Grimberg 2018-12-03  867
> 
> :::::: The code at line 835 was first introduced by commit
> :::::: 3f2304f8c6d6ed97849057bd16fee99e434ca796 nvme-tcp: add NVMe over TCP host driver
> 
> :::::: TO: Sagi Grimberg <sagi@lightbitslabs.com>
> :::::: CC: Christoph Hellwig <hch@lst.de>
> 

I don't understand how the stack frame size is that big. Looks like a
wrong complaint?
