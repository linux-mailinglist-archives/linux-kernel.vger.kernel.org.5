Return-Path: <linux-kernel+bounces-128157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E7895707
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACC1284BC5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D4913118A;
	Tue,  2 Apr 2024 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chvZ2JUe"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4D12BF17
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068549; cv=none; b=JALfwbbuwdW0EBx7qDkkeiN2j+dI6zYWkBXeqDZ5gxc2AkRDpyvFxyDeftxfpGRR3O2nE5TWEWfmq30Lo2xJPbibgw13xyfvlw7oZsbSbEzADF23cdfC9lDRgyQeUjSxLtFoTJddFBjeq0DwmOhv9iqu8bTi3bdyDoBInPr2MZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068549; c=relaxed/simple;
	bh=fQLuhD36E/ci1+0Q+DKy+5OlypO0KV3ocMoLe8264mk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qNVormLXPyMghRpp3KUDhxIUYn7HbE7r2TCIyPqADpKUfyrNKfTgrb+vPlmOpGzz07QOR+9NOM/1aFApDdbAD1KX2v/1L4naJbLGCIXkZJmCkGo6o7m1cybVjuB0jq6hUBqlcnpRqSeZgxMIBYZCagb3SaNyFaQGNB7vC9m7228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=chvZ2JUe; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46ba938de0so696531566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712068545; x=1712673345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7KEJIrVUqbeyt98Ud1PwflhK4nwSINZjdOF29dDrsoo=;
        b=chvZ2JUePsCzvwy1kefS5RqzJYb3n/9/cOkrCZp9TU2tP62LSBg7X/8RWNDNF0J6wS
         Nc5F/8S6Y5rG4bH63JdDYJ2xUfE5580g5vXrA5c3l2eBr6rCdCMCWmg8NsIzbV65gShA
         509/PDYryYtfdPi1OMZpzWQTH26IRL06Tf43Su7R0oU8AGFsHrOTfLUZQmZe2j6UwP1t
         b+s2hLS87Mc5xkBKbQmrImZy14seh2QJwNKDd9w5MxpgFhWIAkEIuDjX/Desyn1Cz/9j
         /JgoBxfgYwNC0TN0ZfcTmJJlQvGNQysijG5yww+Xn6j9JQpC49SOZSq2MI5insAqLFz7
         XEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712068545; x=1712673345;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KEJIrVUqbeyt98Ud1PwflhK4nwSINZjdOF29dDrsoo=;
        b=AHZcHfUvjilSoj6CS3tYFRUmUWWegQSBjR9pxUVLqcY6Uo0W9e2UWjRwX2+Iyr43c0
         BBHO3G3n7bUDUaWoc5rj2uhuZTQkTMl8t1Wr++pJ1C6V41GXp5CEG8quNseWbkP8DLWB
         9mtv3jVUmNISnyPNpTZp7PhJwNO3SrDMvrqk5G2Q2PYqUUJYDj2A1p7qNYLumbxgPYqC
         sTh486Y7OnzpEHfflfHWor8VRLZKOG8N6WdOuUnMDpBd4z7Ac7Nyq3uWX3dL9Epsx/Xu
         gdy5GuJkdx3SDveUKBhRu0zJn5pHaDKiDSFOZ4VT3wHxBNI7UpQ8rDbkFSfkYpuu029w
         1o3w==
X-Forwarded-Encrypted: i=1; AJvYcCU6bNr4XvLBwMVCUFmUUVv870MIGPidP2jbdFIxM3XWMD2G1nNqz9/DkHJVzSCoK2twiwnKcsw+H8fdRYEd4LRX0F2O5yQRzfaTmt51
X-Gm-Message-State: AOJu0YxOlE/h7CZzgMxEON5IGOi9oWX5cZbUOj6oExc31ylA3fmx71Cr
	yo2BqDIoeehS50yBi4lQh2LXH6aADzE7rqPewuhcv5jWmK7tLRBAQnG1ScK6cTE=
X-Google-Smtp-Source: AGHT+IHCofE7Xg160OG2egAJnKF0oiNZHZIWV3DkkXe2HP9pc/DI3G0pkED3atujIwRVqD0byi7FxQ==
X-Received: by 2002:a17:906:9a8d:b0:a47:38c0:fb4e with SMTP id ag13-20020a1709069a8d00b00a4738c0fb4emr7710510ejc.19.1712068544411;
        Tue, 02 Apr 2024 07:35:44 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709062c4d00b00a4df82aa6a7sm6554592ejh.219.2024.04.02.07.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:35:43 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:35:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Shenghao Ding <shenghao-ding@ti.com>,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, lgirdwood@gmail.com,
	broonie@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	perex@perex.cz, tiwai@suse.com, 13916275206@139.com,
	mohit.chawla@ti.com, soyer@irl.hu, jkhuang3@ti.com, tiwai@suse.de,
	pdjuandi@ti.com, manisha.agrawal@ti.com, s-hari@ti.com,
	aviel@ti.com, hnagalla@ti.com, praneeth@ti.com, Baojun.Xu@fpt.com,
	Shenghao Ding <shenghao-ding@ti.com>
Subject: Re: [PATCH v7 3/4] ASoc: PCM6240: Add compile item for PCM6240
 Family driver
Message-ID: <c206cc39-27ad-4a4d-8703-220dc0bf7dab@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331021835.1470-4-shenghao-ding@ti.com>

Hi Shenghao,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenghao-Ding/ASoc-PCM6240-Create-PCM6240-Family-driver-code/20240331-102303
base:   v6.9-rc1
patch link:    https://lore.kernel.org/r/20240331021835.1470-4-shenghao-ding%40ti.com
patch subject: [PATCH v7 3/4] ASoc: PCM6240: Add compile item for PCM6240 Family driver
config: um-randconfig-r081-20240402 (https://download.01.org/0day-ci/archive/20240402/202404021225.mx5KlUlV-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202404021225.mx5KlUlV-lkp@intel.com/

smatch warnings:
sound/soc/codecs/pcm6240.c:1715 pcmdevice_process_block() warn: inconsistent indenting

vim +/fw_entry +1577 sound/soc/codecs/pcm6240.c

051d749b6eaeb0 Shenghao Ding 2024-03-31  1619  static int pcmdevice_process_block(void *ctxt, unsigned char *data,
051d749b6eaeb0 Shenghao Ding 2024-03-31  1620  	unsigned char dev_idx, int sublocksize)
051d749b6eaeb0 Shenghao Ding 2024-03-31  1621  {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1622  	struct pcmdevice_priv *pcm_dev = (struct pcmdevice_priv *)ctxt;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1623  	int subblk_offset = 2, chn, chnend, ret;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1624  	unsigned char subblk_typ = data[1];
051d749b6eaeb0 Shenghao Ding 2024-03-31  1625  
051d749b6eaeb0 Shenghao Ding 2024-03-31  1626  	if (dev_idx) {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1627  		chn = dev_idx - 1;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1628  		chnend = dev_idx;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1629  	} else {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1630  		chn = 0;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1631  		chnend = pcm_dev->ndev;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1632  	}
051d749b6eaeb0 Shenghao Ding 2024-03-31  1633  
051d749b6eaeb0 Shenghao Ding 2024-03-31  1634  	for (; chn < chnend; chn++) {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1635  		switch (subblk_typ) {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1636  		case PCMDEVICE_CMD_SING_W: {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1637  			unsigned short len = get_unaligned_be16(&data[2]);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1638  			int i = 0;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1639  
051d749b6eaeb0 Shenghao Ding 2024-03-31  1640  			subblk_offset += 2;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1641  			if (subblk_offset + 4 * len > sublocksize) {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1642  				dev_err(pcm_dev->dev,
051d749b6eaeb0 Shenghao Ding 2024-03-31  1643  					"%s: byt wr out of boundary\n",
051d749b6eaeb0 Shenghao Ding 2024-03-31  1644  					__func__);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1645  				break;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1646  			}
051d749b6eaeb0 Shenghao Ding 2024-03-31  1647  
051d749b6eaeb0 Shenghao Ding 2024-03-31  1648  			for (i = 0; i < len; i++) {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1649  				ret = pcmdev_dev_write(pcm_dev, chn,
051d749b6eaeb0 Shenghao Ding 2024-03-31  1650  					PCMDEVICE_REG(data[subblk_offset + 1],
051d749b6eaeb0 Shenghao Ding 2024-03-31  1651  						data[subblk_offset + 2]),
051d749b6eaeb0 Shenghao Ding 2024-03-31  1652  					data[subblk_offset + 3]);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1653  				if (ret < 0)
051d749b6eaeb0 Shenghao Ding 2024-03-31  1654  					dev_err(pcm_dev->dev,
051d749b6eaeb0 Shenghao Ding 2024-03-31  1655  						"%s: single write error\n",
051d749b6eaeb0 Shenghao Ding 2024-03-31  1656  						__func__);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1657  
051d749b6eaeb0 Shenghao Ding 2024-03-31  1658  				subblk_offset += 4;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1659  			}
051d749b6eaeb0 Shenghao Ding 2024-03-31  1660  		}
051d749b6eaeb0 Shenghao Ding 2024-03-31  1661  		break;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1662  		case PCMDEVICE_CMD_BURST: {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1663  			unsigned short len = get_unaligned_be16(&data[2]);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1664  
051d749b6eaeb0 Shenghao Ding 2024-03-31  1665  			subblk_offset += 2;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1666  			if (subblk_offset + 4 + len > sublocksize) {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1667  				dev_err(pcm_dev->dev,
051d749b6eaeb0 Shenghao Ding 2024-03-31  1668  					"%s: burst Out of boundary\n",
051d749b6eaeb0 Shenghao Ding 2024-03-31  1669  					__func__);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1670  				break;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1671  			}
051d749b6eaeb0 Shenghao Ding 2024-03-31  1672  			if (len % 4) {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1673  				dev_err(pcm_dev->dev,
051d749b6eaeb0 Shenghao Ding 2024-03-31  1674  					"%s: burst-len(%u) not div by 4\n",
051d749b6eaeb0 Shenghao Ding 2024-03-31  1675  					__func__, len);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1676  				break;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1677  			}
051d749b6eaeb0 Shenghao Ding 2024-03-31  1678  			ret = pcmdev_dev_bulk_write(pcm_dev, chn,
051d749b6eaeb0 Shenghao Ding 2024-03-31  1679  				PCMDEVICE_REG(data[subblk_offset + 1],
051d749b6eaeb0 Shenghao Ding 2024-03-31  1680  				data[subblk_offset + 2]),
051d749b6eaeb0 Shenghao Ding 2024-03-31  1681  				&(data[subblk_offset + 4]), len);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1682  			if (ret < 0)
051d749b6eaeb0 Shenghao Ding 2024-03-31  1683  				dev_err(pcm_dev->dev,
051d749b6eaeb0 Shenghao Ding 2024-03-31  1684  					"%s: bulk_write err = %d\n",
051d749b6eaeb0 Shenghao Ding 2024-03-31  1685  					__func__, ret);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1686  
051d749b6eaeb0 Shenghao Ding 2024-03-31  1687  			subblk_offset += (len + 4);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1688  		}
051d749b6eaeb0 Shenghao Ding 2024-03-31  1689  			break;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1690  		case PCMDEVICE_CMD_DELAY: {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1691  			unsigned int delay_time = 0;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1692  
051d749b6eaeb0 Shenghao Ding 2024-03-31  1693  			if (subblk_offset + 2 > sublocksize) {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1694  				dev_err(pcm_dev->dev,
051d749b6eaeb0 Shenghao Ding 2024-03-31  1695  					"%s: deley out of boundary\n",
051d749b6eaeb0 Shenghao Ding 2024-03-31  1696  					__func__);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1697  				break;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1698  			}
051d749b6eaeb0 Shenghao Ding 2024-03-31  1699  			delay_time = get_unaligned_be16(&data[2]) * 1000;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1700  			usleep_range(delay_time, delay_time + 50);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1701  			subblk_offset += 2;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1702  		}
051d749b6eaeb0 Shenghao Ding 2024-03-31  1703  			break;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1704  		case PCMDEVICE_CMD_FIELD_W:
051d749b6eaeb0 Shenghao Ding 2024-03-31  1705  		if (subblk_offset + 6 > sublocksize) {
051d749b6eaeb0 Shenghao Ding 2024-03-31  1706  			dev_err(pcm_dev->dev,
051d749b6eaeb0 Shenghao Ding 2024-03-31  1707  				"%s: bit write out of memory\n", __func__);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1708  			break;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1709  		}
051d749b6eaeb0 Shenghao Ding 2024-03-31  1710  			ret = pcmdev_dev_update_bits(pcm_dev, chn,
051d749b6eaeb0 Shenghao Ding 2024-03-31  1711  				PCMDEVICE_REG(data[subblk_offset + 3],
051d749b6eaeb0 Shenghao Ding 2024-03-31  1712  				data[subblk_offset + 4]),
051d749b6eaeb0 Shenghao Ding 2024-03-31  1713  				data[subblk_offset + 1],
051d749b6eaeb0 Shenghao Ding 2024-03-31  1714  				data[subblk_offset + 5]);

This line is indented too far.

051d749b6eaeb0 Shenghao Ding 2024-03-31 @1715  		if (ret < 0)
051d749b6eaeb0 Shenghao Ding 2024-03-31  1716  			dev_err(pcm_dev->dev, "%s: update_bits err = %d\n",
051d749b6eaeb0 Shenghao Ding 2024-03-31  1717  				__func__, ret);
051d749b6eaeb0 Shenghao Ding 2024-03-31  1718  
051d749b6eaeb0 Shenghao Ding 2024-03-31  1719  		subblk_offset += 6;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1720  			break;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1721  		default:
051d749b6eaeb0 Shenghao Ding 2024-03-31  1722  			break;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1723  		}
051d749b6eaeb0 Shenghao Ding 2024-03-31  1724  	}
051d749b6eaeb0 Shenghao Ding 2024-03-31  1725  
051d749b6eaeb0 Shenghao Ding 2024-03-31  1726  	return subblk_offset;
051d749b6eaeb0 Shenghao Ding 2024-03-31  1727  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


