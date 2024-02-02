Return-Path: <linux-kernel+bounces-50461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DEE84793E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2C3292DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644B181720;
	Fri,  2 Feb 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iopLHGiz"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEAE15E5C3;
	Fri,  2 Feb 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900742; cv=none; b=KFqAUkTvZ1YgCre1+AoIoFKw8oOZVeRDneMg5tOqUoiWNRe0HBVrqqSQLXOyjj4wx7P4WzKf2aL6VXGmWQeXDCUXVG5GcMMyauynD/6B18f2S1XtTej7vWU6s1jVCHaHTGyJd2kQwe/7wDfoGo5/GVj6fJMpQqbgjCDdnurB3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900742; c=relaxed/simple;
	bh=3dMArMIfpH+Rtl2EZxaqsebVWb3rCZhLbYA5LNUeDZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRBv8Y+QYeeW9SIhsZI+rFdeKNUKPtvmfMDIiCIO4Kw9DlHMqF6oIhSZ+12Cab7XvCUe+T8ckrDVnUXOfXQdPQpTJsu2YD3CXWMNWpbPpwVLaPi8PSOvk2/irasSwb7pOp1kQtWtAKRe3ZDFiACnrTasS9aGw3M96NhuOntMTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iopLHGiz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so2257994a12.1;
        Fri, 02 Feb 2024 11:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900740; x=1707505540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukxRtLoLemzhwimS4cpJYXTJGjmDxYbm8xsKwFLAjjI=;
        b=iopLHGiz6YuAUQdWSD5To6EE12e5tFV3uc950kt1qeFVXBUZ2C0tvaDJDSHtLO0ei2
         rFJfExZ5u9QCpu4IvgbyyXqnvlvrlpTmdpZ4soaHkHEeDigBZ4kx/9uNwNODme5/Gnha
         mwDgg+ep4jAx/UgeVBcui7o3kU/Fl6T6oTcZ2BL2IXMfewRgR5MNly+unbokwe8Hhxh/
         U4SMtEkc4ZZ6WFnYodyuRkagGV5gVLOyQvLgaslwl0cAZLvXrTMCvmoHPGD7ycMo8od+
         ampvj73gPJ18xWoluix6sXo5jiD3Ipq9ozv+7JXWFu6qx7bCYY8dIXVie1Dq4gY21Cnj
         ayHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900740; x=1707505540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukxRtLoLemzhwimS4cpJYXTJGjmDxYbm8xsKwFLAjjI=;
        b=vZlz+SNhqzN+wXIwZGhoQDtP0GHgyiQY9ytBN8iBw8G8mWUgW9mMsmii+avdMsBe0Y
         RhAu/SlO2loswPXNkH8dMtfBp1wOpKanXqZNBjp1ssqv2YHL8QYbvBVDjOMGYP5637uR
         uQVCfSXoi3ZRHhovRPk/XVRvOCeCkkR54P7OfzmGO4RQPpDHViMTP+8G1w/JhjBF7MjJ
         aU71qqjWrAoHioE9IvnP2IRIoAs8Ynv8wV99Ij+tKWsavgmcIffxOvBdR+N27jeqILom
         MSNaoGbrU46IIj3EzI5HyFzzUvR8TMYlJtixnbOAGwxJ/N7wilcELlXo9QEm9aboOFYJ
         0Nvg==
X-Gm-Message-State: AOJu0YwHDmZ6EyVe7T2Dd3RnCwxSfOfsVnfuWZvUC1jEHjCLL0FZWQbF
	shaDbAGaM7xxWmsgknvQ7NPqPVEEAkU52e4cDdimngHEGKyiJxtp
X-Google-Smtp-Source: AGHT+IGmaen8ComTq/HdjMtgy5XjXjq2iwXuT68EEE79kpck2iGiRHoB9wCjjMPTkqiVPb8j9irzVw==
X-Received: by 2002:a17:90a:d242:b0:296:2f9b:8c2f with SMTP id o2-20020a17090ad24200b002962f9b8c2fmr4187731pjw.40.1706900740497;
        Fri, 02 Feb 2024 11:05:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX3w1PsNkAwT4t7RZ6A1o96pgCOS295/958/g+cL5zFxShuJVPq4FaFWq3tHuZe8AEqylV4QmM31QSD/XGuCQx3y3OqvZvc2OgTINC4/bjBfyL8aJFHtnhSs327jMqn5o3JVDtXq3FlM73zHr8Z0SzASTaJrPFkL8hwP/hgsx2T1F4prafNtamcvRCsF1XT1VisOwiatEYwZg3Ruv+dDvhMmUhjF54vKZ1YRv/5f3DulohOxaezbA66SzATlTdy32mndNairhQqvlY2LjIwNPk9F1AYa/gZp0rH1PkIwTO7Jas3zVP73Q4iqt7NMmFORQFDSkjv0XNzNDeCk7EUQHXEjbuOiDn1TelNYkXwGfzrw0dSVyCNTEi6zAfL33tqbW0ffZj25n0TJ48ylMWXQOvpQ0iPH5/twRZB8WvyaFR3YxpTirvxEd0dSAfyoXu2ihevZzdoXF11mLTVA/m8PbVf5VsFxJGssG0piiQTSFtr7ayF2BobSLlQ46LwkPQ8Bjj9mq/MXAFfRs0WgY6XONYn3iUwn5ICYt5aZ6va2cXjXti5D2whV+Np6u3dxroFNm0md5zWh/AgfU+AMZlMxD/VN7RQws31yCokHHLS/L17p1JSCdJez3zy4spF9/AKHhun+bPE0adqqu4hpu4ouFutXkLxDeeseY+KJ3GLBFBf/Wr1bNB20/7+8UN6VcVPTxw/YnnYdlMjRdhJSFfpaqZWcOU5c/N1Baeoju2OcMeUE7JH/bRsmi3j3+gAAGIPAzhxdgOWJqY0LXuPu0OiB/AjUeqKQKtctrr068sL90KwIcBT4aOZ288=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090adf8f00b00295e671dfb8sm358897pjv.22.2024.02.02.11.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:05:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 11:05:39 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jdelvare@suse.com, corbet@lwn.net,
	broonie@kernel.org, naresh.solanki@9elements.com,
	vincent@vtremblay.dev, patrick.rudolph@9elements.com,
	luca.ceresoli@bootlin.com, bhelgaas@google.com, festevam@denx.de,
	alexander.stein@ew.tq-group.com, heiko@sntech.de,
	jernej.skrabec@gmail.com, macromorgan@hotmail.com,
	forbidden405@foxmail.com, sre@kernel.org, linus.walleij@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	cosmo.chou@quantatw.com
Subject: Re: [PATCH v4 3/3] hwmon: Add driver for Astera Labs PT5161L retimer
Message-ID: <f1e383d8-23d6-4761-894c-888ca8f7204c@roeck-us.net>
References: <20240115100518.2887549-1-chou.cosmo@gmail.com>
 <20240115100518.2887549-4-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115100518.2887549-4-chou.cosmo@gmail.com>

On Mon, Jan 15, 2024 at 06:05:18PM +0800, Cosmo Chou wrote:
> This driver implements support for temperature monitoring of Astera Labs
> PT5161L series PCIe retimer chips.
> 
> This driver implementation originates from the CSDK available at
> Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
> The communication protocol utilized is based on the I2C/SMBus standard.
> 
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>

That gives me:

WARNING: Improper SPDX comment style for 'drivers/hwmon/pt5161l.c', please use '//' instead
#237: FILE: drivers/hwmon/pt5161l.c:1:
+/* SPDX-License-Identifier: GPL-2.0-or-later */

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#237: FILE: drivers/hwmon/pt5161l.c:1:
+/* SPDX-License-Identifier: GPL-2.0-or-later */

CHECK: struct mutex definition without comment
#304: FILE: drivers/hwmon/pt5161l.c:68:
+	struct mutex lock;

CHECK: Lines should not end with a '('
#419: FILE: drivers/hwmon/pt5161l.c:183:
+		ret = pt5161l_write_block_data(

and many more of the latter. I'd fix it up if it was just one or two,
and I don't care about the mutex definition comment, but

	total: 0 errors, 2 warnings, 9 checks, 755 lines checked

is just too much.

From Documentation/hwmon/submitting-patches.rst:

* Please run your patch through 'checkpatch --strict'. There should be no
  errors, no warnings, and few if any check messages. If there are any
  messages, please be prepared to explain.

Please fix and resubmit. No need to resubmit the other patches in the
series, since I already applied those.

Thanks,
Guenter

