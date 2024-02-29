Return-Path: <linux-kernel+bounces-86378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5780186C4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A761C211B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375B05821B;
	Thu, 29 Feb 2024 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0iVNZstk"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5B5810F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197960; cv=none; b=EKokQzoeJa8/0bBLtTEf40gkg4QqWFnTtAKMqTJuwfThcPun2zFnFBFP7V8ScmPH1qIezp5/jDMKFxTu/lE3TUJgCnOtMBQPyTaiNtCrFSz5Oe0SECEsryjaBD1dR3vFjTTpjpsk1lxs1epxJQqLo3qcUv7Qo6Urfjoud2qmFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197960; c=relaxed/simple;
	bh=Zz5c60WUwMpr/mkl3dkJSt0O8VDXt1cQkdF8ruLXMwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkRc/RTuwa2IqFXmiVcIKfzEv7Bk0COuCj54SQwbmW50eEIhLcvyoFy71udCnPihAMopcU2ehpfnwf6j+7cfpZxPM5i5YNh4183xbHP0xJoce0KU65ddanEXHKeoXK+aHu7s5CfePANr7ytuB1UfVd6lZAxiH8B1Fre3N08eI9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0iVNZstk; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a36126ee41eso109087166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709197956; x=1709802756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtoUY+sUx4i7491sOvpQ7a18yb0FYFKsvjRSHokqh7A=;
        b=0iVNZstk2jSA94ncqkwVldsodWUyRO8f5ztrb32rHgnLYTwEpM+t1zu1sAnzZoAH1o
         6+Omr/YLt/fTMbmYivDS8JswL+zD9jAuvXgZ2vLUEhVIvttLk6nzc/V8ljDKY74V7eic
         OdoeBIFjb/P2P9gA6dfso3DFYhPJgRK9KGNfj+xff4DDMrfIPA7LAcVNabY1vRb0w95D
         wsxPjMB79aIxypYCelMyFH/qs8L7ZHrU9v84SwM6F4gk17u3ENFPO5UNGwW5kDyQarea
         EcmGvHIuhCIGCFfL8xgkpEsl5PzmczQ/f/rgWFuZRGf064fS6iUYU4bftFy0ldYrjADZ
         l2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709197956; x=1709802756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtoUY+sUx4i7491sOvpQ7a18yb0FYFKsvjRSHokqh7A=;
        b=nXgPAN3K6zpcIAlkD1AkjfN9mbPoOB6pifV/rp5XTmQLGQIOfvHQxP2hCAM1GF1cHp
         Ns2abWkmHs+EZ5Syvo0dSk3AWTUN7vxa/axrl2Ob9VY3hoSIzNE91to4WpO0WWhb+WzW
         Mp7FvJLu1Wt+A/iZfFugUZtppLfwZacSa4q1EL1E6KqeFupC3t9jFpPgfnQNWLr/Zxs7
         l8n4UQAkdaWKOaemqY//RwwQaegrcEHjY+zMfAnNeBY29/T6uVjmtZfd4hqoavZPD+F3
         ZOqD/mYf5kYiOR5SInmh4Cz1HNV3o86czciU6Zdc5+eYd1A6xPu2XGBtlG+YDynyaFSd
         tS+g==
X-Forwarded-Encrypted: i=1; AJvYcCV0pubxpcv2ntM9tCC2p/jg3J8PeoCy+7wHzOIqPKwpXWdTHyv8GlUtqi/f3+k8J+BGQWAHs70L5LiK8GSpK6RigbFCWPApPKiAFYSW
X-Gm-Message-State: AOJu0Yzzg5VS7f63YTpw9a36Hz8mT7IkxLYtCxV0yzc/f8W6LRZVEQ1+
	vExgophclFR0mDCHzzY9ZFFQA8oln0NLcrR+q8qZw7WrgOavTVAMXev4qh4WUPA=
X-Google-Smtp-Source: AGHT+IEWZelIZUYOUxf791XMFb0Cg0LC0EFoqAd1hBPXslI7aSFuvjl8VfWb+ocyRVNNkifawwnEfQ==
X-Received: by 2002:a17:906:f845:b0:a3f:d7ee:5fdc with SMTP id ks5-20020a170906f84500b00a3fd7ee5fdcmr940823ejb.46.1709197955800;
        Thu, 29 Feb 2024 01:12:35 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id tz5-20020a170907c78500b00a3f9a10f792sm478027ejc.7.2024.02.29.01.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:12:35 -0800 (PST)
Date: Thu, 29 Feb 2024 10:12:34 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Plachno <lukasz.plachno@intel.com>,
	Jakub Buchocki <jakubx.buchocki@intel.com>,
	Pawel Kaminski <pawel.kaminski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net 4/5] ice: Implement VF LLDP RX support on VF
Message-ID: <ZeBKgpUurx90HDET@nanopsycho>
References: <20240228155957.408036-1-larysa.zaremba@intel.com>
 <20240228155957.408036-5-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228155957.408036-5-larysa.zaremba@intel.com>

Wed, Feb 28, 2024 at 04:59:48PM CET, larysa.zaremba@intel.com wrote:

[...]


>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>index 9c2c8637b4a7..af3611055e60 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -4704,9 +4704,60 @@ void ice_deinit_dev(struct ice_pf *pf)
> 	ice_clear_interrupt_scheme(pf);
> }
> 
>+static ssize_t rx_lldp_show(struct device *dev, struct device_attribute *attr,
>+			    char *buf)
>+{
>+	struct ice_pf *pf = dev_get_drvdata(dev);
>+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
>+
>+	return sysfs_emit(buf, "%u\n", vsi->rx_lldp_ena);
>+}
>+
>+static ssize_t rx_lldp_store(struct device *dev, struct device_attribute *attr,
>+			     const char *buf, size_t count)
>+{
>+	struct ice_pf *pf = dev_get_drvdata(dev);
>+	struct ice_vsi *vsi;
>+	bool ena;
>+	int err;
>+
>+	if (test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags)) {
>+		dev_err(dev, "Toggling Rx LLDP for PF is only allowed when FW LLDP Agent is disabled");
>+		return -EPERM;
>+	}
>+
>+	err = kstrtobool(buf, &ena);
>+	if (err)
>+		return -EINVAL;
>+
>+	vsi = ice_get_main_vsi(pf);
>+
>+	if (ena == vsi->rx_lldp_ena) {
>+		dev_dbg(dev, "Rx LLDP already %sabled", ena ? "en" : "dis");
>+		return count;
>+	}
>+
>+	ice_cfg_sw_lldp(vsi, false, ena);
>+
>+	return count;
>+}
>+
>+static DEVICE_ATTR_RW(rx_lldp);
>+
>+static int ice_init_rx_lldp_sysfs(struct ice_pf *pf)
>+{
>+	return device_create_file(ice_pf_to_dev(pf), &dev_attr_rx_lldp);

Don't add driver specific sysfs knobs please.

pw-bot: reject

[...]

