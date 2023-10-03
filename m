Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6593C7B66CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbjJCKxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbjJCKxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:53:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90827BB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:53:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso7249225e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 03:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696330409; x=1696935209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1zEdiBl0ExGGXae3livewx7OK91KyMJUhCwm90pFhU=;
        b=dAbVnjeTtuGXmH22VTPslFg0+3MgTbf3jbQKWpVP+DHFK3FWL0t8nt7whadL1q6jxy
         B/RJDH0gr8ojdF0iZ9enlqVsCi4T+yco3zI11rJUsigsg2P9i5sCVisGpdPLxp3fpuZq
         IlHjgmaqhkDoEj0HBiLjeHwhW3A+Pl8pjw94lZNk8QJx/hn05zjsDzCLRJMac4Y77FYE
         Ek2qMkkaYSFdCRc+w0zL9Vi26rQsyzDxEHDZPlwLyf+PKW3mGOOgEMBin9Kr8m+k7pC/
         bLmppTep3yMcYgBJ46Gj91iTuySEhCVyofp6CpUKNoPwTNw3yR0Y4+6I5tXzbHVGjB6L
         m83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696330409; x=1696935209;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1zEdiBl0ExGGXae3livewx7OK91KyMJUhCwm90pFhU=;
        b=Gkracp3Hz24w/gis19emyrzrjEoazzGBRrALq6fVU7Xh25wa9zMp5l6w/KRU8o8hhI
         C/PGePzM/ogw/Tk+WASFF9MvUIANJsdG7ARfvGCy1Zt4H+XduT+0nZdaAc4Y0u/XrdaA
         00k88ABeo/plIqrSHz1C8z5preU7xMf7g0TGP/yL5QJVyVBhivnC1yW2clkSmDBNzwRT
         3LSZroEN2vbJOYG0ozoWAqQxnIuhC439hCV4pAAGOX+hZ1JS0HPXtFJBM23l5BLiVzCd
         S+9H+PmH/6kU/zhgs6eH9Bq7XBL88BdgNuQgUkBBG+090Ch/wlP7p7pVwD34IP3ww/Vp
         chMQ==
X-Gm-Message-State: AOJu0YzbKA6a/q3UqDRpVrAXUYgVqhaUsJQIy0HitZrsLk1CV4SPMJ5n
        x19NI2Do+rHJPTcrKxr2sCf0Eg==
X-Google-Smtp-Source: AGHT+IFrlFTbWNC8M7mfAowD4//qf9eH7koPKNnANa5WAno4xaY32Mn62vsE1r4OcW8lmx133LVOGQ==
X-Received: by 2002:a5d:4951:0:b0:31f:fb02:4dcd with SMTP id r17-20020a5d4951000000b0031ffb024dcdmr12544705wrs.4.1696330408555;
        Tue, 03 Oct 2023 03:53:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e11-20020a056000194b00b0032320a9b010sm1305878wry.28.2023.10.03.03.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:53:27 -0700 (PDT)
Date:   Tue, 3 Oct 2023 13:53:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, David Lechner <dlechner@baylibre.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 26/27] staging: iio: resolver: ad2s1210: implement
 fault events
Message-ID: <d54a43ad-0044-465c-92f4-2ffd46ccf983@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929-ad2s1210-mainline-v3-26-fa4364281745@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/dt-bindings-iio-resolver-add-devicetree-bindings-for-ad2s1210/20230930-014031
base:   5e99f692d4e32e3250ab18d511894ca797407aec
patch link:    https://lore.kernel.org/r/20230929-ad2s1210-mainline-v3-26-fa4364281745%40baylibre.com
patch subject: [PATCH v3 26/27] staging: iio: resolver: ad2s1210: implement fault events
config: x86_64-randconfig-161-20231002 (https://download.01.org/0day-ci/archive/20231003/202310031839.tKR53HoP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231003/202310031839.tKR53HoP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202310031839.tKR53HoP-lkp@intel.com/

smatch warnings:
drivers/staging/iio/resolver/ad2s1210.c:436 ad2s1210_single_conversion() error: buffer overflow 'st->rx' 2 <= 2

vim +436 drivers/staging/iio/resolver/ad2s1210.c

ecf16f4922f691 David Lechner    2023-09-29  391  static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
29148543c52146 Jonathan Cameron 2011-10-05  392  				      struct iio_chan_spec const *chan,
e9336a85ceb885 David Lechner    2023-09-29  393  				      int *val)
817e5c65c511d4 Graf Yang        2010-10-27  394  {
ecf16f4922f691 David Lechner    2023-09-29  395  	struct ad2s1210_state *st = iio_priv(indio_dev);
ecf16f4922f691 David Lechner    2023-09-29  396  	s64 timestamp;
69cc7fbdcdf2e3 David Lechner    2023-09-29  397  	int ret;
817e5c65c511d4 Graf Yang        2010-10-27  398  
817e5c65c511d4 Graf Yang        2010-10-27  399  	mutex_lock(&st->lock);
69cc7fbdcdf2e3 David Lechner    2023-09-29  400  	gpiod_set_value(st->sample_gpio, 1);
ecf16f4922f691 David Lechner    2023-09-29  401  	timestamp = iio_get_time_ns(indio_dev);
817e5c65c511d4 Graf Yang        2010-10-27  402  	/* delay (6 * tck + 20) nano seconds */
817e5c65c511d4 Graf Yang        2010-10-27  403  	udelay(1);
817e5c65c511d4 Graf Yang        2010-10-27  404  
29148543c52146 Jonathan Cameron 2011-10-05  405  	switch (chan->type) {
29148543c52146 Jonathan Cameron 2011-10-05  406  	case IIO_ANGL:
69cc7fbdcdf2e3 David Lechner    2023-09-29  407  		ret = ad2s1210_set_mode(st, MOD_POS);
29148543c52146 Jonathan Cameron 2011-10-05  408  		break;
29148543c52146 Jonathan Cameron 2011-10-05  409  	case IIO_ANGL_VEL:
69cc7fbdcdf2e3 David Lechner    2023-09-29  410  		ret = ad2s1210_set_mode(st, MOD_VEL);
29148543c52146 Jonathan Cameron 2011-10-05  411  		break;
29148543c52146 Jonathan Cameron 2011-10-05  412  	default:
29148543c52146 Jonathan Cameron 2011-10-05  413  		ret = -EINVAL;
29148543c52146 Jonathan Cameron 2011-10-05  414  		break;
29148543c52146 Jonathan Cameron 2011-10-05  415  	}
29148543c52146 Jonathan Cameron 2011-10-05  416  	if (ret < 0)
29148543c52146 Jonathan Cameron 2011-10-05  417  		goto error_ret;
ecf16f4922f691 David Lechner    2023-09-29  418  	ret = spi_read(st->sdev, &st->sample, 3);
29148543c52146 Jonathan Cameron 2011-10-05  419  	if (ret < 0)
817e5c65c511d4 Graf Yang        2010-10-27  420  		goto error_ret;
29148543c52146 Jonathan Cameron 2011-10-05  421  
29148543c52146 Jonathan Cameron 2011-10-05  422  	switch (chan->type) {
29148543c52146 Jonathan Cameron 2011-10-05  423  	case IIO_ANGL:
ecf16f4922f691 David Lechner    2023-09-29  424  		*val = be16_to_cpu(st->sample.raw);
29148543c52146 Jonathan Cameron 2011-10-05  425  		ret = IIO_VAL_INT;
29148543c52146 Jonathan Cameron 2011-10-05  426  		break;
29148543c52146 Jonathan Cameron 2011-10-05  427  	case IIO_ANGL_VEL:
ecf16f4922f691 David Lechner    2023-09-29  428  		*val = (s16)be16_to_cpu(st->sample.raw);
29148543c52146 Jonathan Cameron 2011-10-05  429  		ret = IIO_VAL_INT;
29148543c52146 Jonathan Cameron 2011-10-05  430  		break;
29148543c52146 Jonathan Cameron 2011-10-05  431  	default:
5e99f692d4e32e David Lechner    2023-09-21  432  		ret = -EINVAL;
5e99f692d4e32e David Lechner    2023-09-21  433  		break;
29148543c52146 Jonathan Cameron 2011-10-05  434  	}
29148543c52146 Jonathan Cameron 2011-10-05  435  
ecf16f4922f691 David Lechner    2023-09-29 @436  	ad2s1210_push_events(indio_dev, st->rx[2], timestamp);
                                                                                          ^^^^^^
Apparently ->rx only has 2 elements.

ecf16f4922f691 David Lechner    2023-09-29  437  
817e5c65c511d4 Graf Yang        2010-10-27  438  error_ret:
69cc7fbdcdf2e3 David Lechner    2023-09-29  439  	gpiod_set_value(st->sample_gpio, 0);
817e5c65c511d4 Graf Yang        2010-10-27  440  	/* delay (2 * tck + 20) nano seconds */
817e5c65c511d4 Graf Yang        2010-10-27  441  	udelay(1);
817e5c65c511d4 Graf Yang        2010-10-27  442  	mutex_unlock(&st->lock);
29148543c52146 Jonathan Cameron 2011-10-05  443  	return ret;
817e5c65c511d4 Graf Yang        2010-10-27  444  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

