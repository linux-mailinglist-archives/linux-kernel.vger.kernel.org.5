Return-Path: <linux-kernel+bounces-109270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DBA88170D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021FD1F23305
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C76A8BA;
	Wed, 20 Mar 2024 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP93OzJq"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC47BA45;
	Wed, 20 Mar 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957812; cv=none; b=KvWuz3sRHKjBKls37AUg+Rw1J46Ai+ok5c4aiqlssz38offIVFqSGD+QiNSQesRnL3IRQroMUHuD5xiFRLYF74wSWGgIwrCGnN2Bw3aRUa6WFTT3IAtywacYa3RwRbwKU+WUlFq+bqC6HeTPtNW/2lHoMn8AHSIS6K7eF/7YBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957812; c=relaxed/simple;
	bh=Ed1I1kIY0Feqy3rs76Gh064Y1IF28xMwtxyZdBPm2NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7015FXYR4R7s22GsIkJF3KESKUBNV03O7wITm60FcMdev9mHjimNVSLeOve6OoB8cfgm34haLlTqdQdqpjfPAIbfBBGKbr/X4Ol1gR5AJKWml+3qPuwBu/aUEcycIRGycPc5/wYB6qxUKZSTYd2zXSjvS3KTgAFqFUpzHAhYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iP93OzJq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dfff641d10so277945ad.2;
        Wed, 20 Mar 2024 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710957810; x=1711562610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fe7+QgceZjZtuMFOC/wsDTnTO94d6hKvWRrBFM6nBWE=;
        b=iP93OzJqSAbyYpCERL7fMvUaSRjtX+WBXCAcu5ob2NGsTq8zFGfA630NzYucvPE/ly
         PvSyuVn5B8msv1HAs2mGtO3y3+1xd6Pi/sVnFoV09yc6Mz9YpJ5vDUOLUfZFeYLV7+Ri
         1iiR+c2onau+EO6XqpXOVk//74G3MBM8QrqDDjaR9iBqotU+vJZpUuTUvzKxq1Hr3f6f
         7pax4vPSUuRaRM4T5RPlwpbKCYciHdomvOVU5b8iAaM9qm8xstDfF8/NuLNe2I7ULmx4
         qJWib01E30+LOJn4ITXCcIRy6CuzM3/Udn+59tLe+pe29WwiwTyChavVW6lNKt6ipQQ6
         m9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957810; x=1711562610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fe7+QgceZjZtuMFOC/wsDTnTO94d6hKvWRrBFM6nBWE=;
        b=kLakEWZjn7/Bww7XGUewa/AZ+hzFOmlmmBIPHFY1tCxSpHstGLelW/ljWXiF9k3yL0
         LXgC3iREgSq76RydAsw/XoyfvnuqlzX2d0lecGibW9lqwOoqXGLeP3P6s3pfwnQhgApZ
         ocoRBUoBtdSVjF0al4TonkjLuDittee8GpY+VgJk8obAXhqlB0e3NwhuAoUxGat2lQXQ
         uPgCPzKHsTglD2jSHQ+EmpHtTCaSJt4GoyWHu2AzkceMJYg9DTK8V/HqKTE2Fr/W8Jmb
         RGBacgKte0oLUEa9nC60QvfDBQu8PJwlpBwaHJNcHnAeHhno113BtJZmp8ONYOSJwNvg
         fE+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeBADOO+TefesbYAsSqgXTe7F+HotI5Q8K9Z1fhh3d2gDqoJ56EIxJu34NWjQIExAv7aDnc5siLiEwlCNRrBCGV9FlHxypBxnbvMsSe1ugQAu9j76/qdyhylmKUudDmC4MuwWPL4ju8sUFWXatE+97p/+cLDcuLS+IxivyiWOGWdKKEzRI
X-Gm-Message-State: AOJu0Yzpei0K1cAjXN8nA4dXeSZZ09laoaFt+qTYLqiVXvvcLvKLwx5g
	TYEAoTf2N1zom4iaYOoA7udPCn/vqPMAKlKiMV61+Lo1IyJrM7WR
X-Google-Smtp-Source: AGHT+IFFRnrbIv+zEXFsZYEZVqnWgrBJ55jSh4gJkPcPwRtlksgsWMna4/o7BKn9T2JkLcq5eMh0Xg==
X-Received: by 2002:a17:902:7c87:b0:1de:eca6:483d with SMTP id y7-20020a1709027c8700b001deeca6483dmr16898141pll.27.1710957809804;
        Wed, 20 Mar 2024 11:03:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b001dd95b5dd0fsm9801984plg.69.2024.03.20.11.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:03:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Mar 2024 11:03:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: lm87: convert to dtschema
Message-ID: <13eff821-e800-415c-bf0c-6d9c11ece565@roeck-us.net>
References: <20240320-hwmon_yaml-v1-0-a349ca21ccab@gmail.com>
 <20240320-hwmon_yaml-v1-1-a349ca21ccab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-hwmon_yaml-v1-1-a349ca21ccab@gmail.com>

On Wed, Mar 20, 2024 at 06:04:57PM +0100, Javier Carrasco wrote:
> Convert existing bindings to dtschema to support validation.
> 
> This is a straightforward conversion with no new properties.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Applied to hwmon-next.

Please note that I'll push the branch after the commit window closed.

Thanks,
Guenter

