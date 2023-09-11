Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7444079A5D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjIKISQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjIKISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:18:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A58CEA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:18:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401ec23be82so46353325e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694420281; x=1695025081; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghOk3mQjRD6nktkkJO9Z2clGd3jvPgI65U2kpsQhXa0=;
        b=VJEJug0hyyEXQMGNnF8lLgGJyCGT+Ep1kfTRlPCyc0th6OOxeccgFKyY4mSscaQqAw
         mKmPiNcNlEBdOTvyqxKEJvHii9r6nQEIT5d9JeOJXrqsJuU1agz0ygjGDkLQu9ywbjTW
         a+x1DFk2wJmYTobrHEe3H0GFDkoaaePFZuu6ED6q9Yb6VoPQFAw/9Lx11TFjZzSG41KQ
         SgmG+UcQCaIvu3HYoFgVU1iR/Fd75RMEm8eYPBb5BJD0IPg6+YOJQFPsOv1GjjUD3xoz
         nXuKsHDTrqIhQEIyxuZzm2XVZomN2kZImXPN4cWhxh40RxkpYt6liMmUkVZDhE5iEHCU
         ZJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420281; x=1695025081;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghOk3mQjRD6nktkkJO9Z2clGd3jvPgI65U2kpsQhXa0=;
        b=VNq6YaMxfm5+zTsn2AGSyEi1xxOR/Y2urKZlGteNWr5fkdO6/JVGptdCer+mQUdhQl
         j0GCyRKuijvaZGRSNjyHCeTF/D/odo6xwpLnRGW1W/kFKdDpmPiR7z3jEnZmHT8t9b0A
         ZxYdJkmMKPB0YduqEE0veatBDPielZEP6wqnc70gSDsql+pzcqie4nx0dn/qCSg+368p
         jLFz3bDj2JsUW+UkLAvZLIeTgluDculolE7y1opW/kjhHddQsB0i9urZ9MekwiK1aS+U
         K2fd6sAxC9HTtg4JN1WPqbHsKAQi3mi3PPIkZCxRbjKdVkEza3G+q/v2yNeatYJY7prm
         p6qg==
X-Gm-Message-State: AOJu0YyQo3Lh6qfNMkvltEqFhj8jw2Su7PIVEnU9HVxdkFysBaeZ5ED3
        +aXP2GrAZo2y2qnFFkxTBi+Gzw==
X-Google-Smtp-Source: AGHT+IFNDdz058vs4BTxajc1ALDRYm9virYOJkO60ysTS5r67aIuq/AAZX2CYNe3A5EYX1ziG3MITA==
X-Received: by 2002:a05:600c:1d82:b0:402:f510:e5b3 with SMTP id p2-20020a05600c1d8200b00402f510e5b3mr7681351wms.2.1694420280716;
        Mon, 11 Sep 2023 01:18:00 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u3-20020a05600c210300b003fe601a7d46sm12445939wml.45.2023.09.11.01.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:18:00 -0700 (PDT)
Date:   Mon, 11 Sep 2023 11:17:57 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Hilda Wu <hildawu@realtek.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alex Lu <alex_lu@realsil.com.cn>,
        Simon Horman <simon.horman@corigine.com>
Subject: net/bluetooth/msft.c:563 msft_add_monitor_sync() warn: passing zero
 to 'PTR_ERR'
Message-ID: <6b4f7617-8885-4444-9e59-2ddb5994b2b5@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   32bf43e4efdb87e0f7e90ba3883e07b8522322ad
commit: 9e14606d8f38ea52a38c27692a9c1513c987a5da Bluetooth: msft: Extended monitor tracking by address filter
config: x86_64-randconfig-161-20230906 (https://download.01.org/0day-ci/archive/20230909/202309091157.V0PEAQVg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230909/202309091157.V0PEAQVg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202309091157.V0PEAQVg-lkp@intel.com/

smatch warnings:
net/bluetooth/msft.c:563 msft_add_monitor_sync() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +563 net/bluetooth/msft.c

182ee45da083db Luiz Augusto von Dentz 2021-10-27  549  	list_for_each_entry(entry, &monitor->patterns, list) {
182ee45da083db Luiz Augusto von Dentz 2021-10-27  550  		pattern = (void *)(pattern_data->data + offset);
182ee45da083db Luiz Augusto von Dentz 2021-10-27  551  		/* the length also includes data_type and offset */
182ee45da083db Luiz Augusto von Dentz 2021-10-27  552  		pattern->length = entry->length + 2;
182ee45da083db Luiz Augusto von Dentz 2021-10-27  553  		pattern->data_type = entry->ad_type;
182ee45da083db Luiz Augusto von Dentz 2021-10-27  554  		pattern->start_byte = entry->offset;
182ee45da083db Luiz Augusto von Dentz 2021-10-27  555  		memcpy(pattern->pattern, entry->value, entry->length);
182ee45da083db Luiz Augusto von Dentz 2021-10-27  556  		offset += sizeof(*pattern) + entry->length;
182ee45da083db Luiz Augusto von Dentz 2021-10-27  557  	}
182ee45da083db Luiz Augusto von Dentz 2021-10-27  558  
182ee45da083db Luiz Augusto von Dentz 2021-10-27  559  	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, total_size, cp,
182ee45da083db Luiz Augusto von Dentz 2021-10-27  560  			     HCI_CMD_TIMEOUT);
182ee45da083db Luiz Augusto von Dentz 2021-10-27  561  
ce78e557ff8819 Soenke Huster          2022-07-22  562  	if (IS_ERR_OR_NULL(skb)) {
9e14606d8f38ea Hilda Wu               2023-06-21 @563  		err = PTR_ERR(skb);
9e14606d8f38ea Hilda Wu               2023-06-21  564  		goto out_free;

This returns success if __hci_cmd_sync() returns NULL.

I don't think __hci_cmd_sync() can return NULL.  It is a design fail if
it can.  And it needs to be commented what the NULL means.  And yet this
file consistently assumes that __hci_cmd_sync() can be NULL.


ce78e557ff8819 Soenke Huster          2022-07-22  565  	}
182ee45da083db Luiz Augusto von Dentz 2021-10-27  566  
9e14606d8f38ea Hilda Wu               2023-06-21  567  	err = msft_le_monitor_advertisement_cb(hdev, hdev->msft_opcode,
b747a83690c8f5 Manish Mandlik         2022-07-20  568  					       monitor, skb);
9e14606d8f38ea Hilda Wu               2023-06-21  569  	if (err)
9e14606d8f38ea Hilda Wu               2023-06-21  570  		goto out_free;
9e14606d8f38ea Hilda Wu               2023-06-21  571  
9e14606d8f38ea Hilda Wu               2023-06-21  572  	handle_data = msft_find_handle_data(hdev, monitor->handle, true);
9e14606d8f38ea Hilda Wu               2023-06-21  573  	if (!handle_data) {
9e14606d8f38ea Hilda Wu               2023-06-21  574  		err = -ENODATA;
9e14606d8f38ea Hilda Wu               2023-06-21  575  		goto out_free;
9e14606d8f38ea Hilda Wu               2023-06-21  576  	}
9e14606d8f38ea Hilda Wu               2023-06-21  577  
9e14606d8f38ea Hilda Wu               2023-06-21  578  	handle_data->rssi_high	= cp->rssi_high;
9e14606d8f38ea Hilda Wu               2023-06-21  579  	handle_data->rssi_low	= cp->rssi_low;
9e14606d8f38ea Hilda Wu               2023-06-21  580  	handle_data->rssi_low_interval	  = cp->rssi_low_interval;
9e14606d8f38ea Hilda Wu               2023-06-21  581  	handle_data->rssi_sampling_period = cp->rssi_sampling_period;
9e14606d8f38ea Hilda Wu               2023-06-21  582  
9e14606d8f38ea Hilda Wu               2023-06-21  583  out_free:
9e14606d8f38ea Hilda Wu               2023-06-21  584  	kfree(cp);
9e14606d8f38ea Hilda Wu               2023-06-21  585  	return err;
b747a83690c8f5 Manish Mandlik         2022-07-20  586  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

