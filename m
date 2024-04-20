Return-Path: <linux-kernel+bounces-152127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDB68AB986
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148A41F2162B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FACDDD8;
	Sat, 20 Apr 2024 04:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLr260R3"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3395AD53F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 04:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713587083; cv=none; b=jEwaw5NAF/Jn/jc49vOtnvOTn02mZWkCeAUHAyvW6vHB4fAP1LEA3dem0n1WnqLS0Kq16x9o82SwPNvxUVXE66dahuC/+evK1oqAqfM9RQLxS2e9KEmmzNJN7/qT2/wXJGTyhPBzpuhqMr1CHfhi+GFv4ydgQNlfWwM9KRycQx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713587083; c=relaxed/simple;
	bh=SEfBo+FOQeeb78hFykWHUasQB5Dn8+pK0YDrhkAamu4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=I1X0rCqI1O9ep9586SfGTn0ZCJ9xE16xrdVGvPNymj9mPbLefJXU1hi3t22+FVYOUTh2fmchudXpzRniQjeT+4teJu2rlb+NFJLT+Rk8flhuISMnfhzkHqSF02VDf/cPp40F7z7WJFHrsW/Gk84YSc28V7KIVXRDUEvwegHXBkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLr260R3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34665dd7744so1774906f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713587080; x=1714191880; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/esIK52jSr8O9hdbHulpIcvgI+D8w5KpuBs8WBK9fds=;
        b=NLr260R3kNtzwbqjCfsZHcsjMj+wa37M3SchbBra1/Ni+SFtlh4ey31ELx2tT97shp
         A0zrxMgcQsj0ymd0MN3d3RU75zb2EXZ57F0v98dFtMIhtLEywuccmizL561+1fNBVKJQ
         CcdgCdJ4zqOWmNUB58tqdAUbffnIi7Hw4ri5xw2JEf5gziJbeGepNGRLg2l1IPYMY813
         UmPNB08TRYntkJqxq3DR8hR3V2sDyF6jcU+HpuHpSOHhG1Tb7jHJGs34KvV9AkDDwFgM
         MYwVAPBE7C8qm4LSSmnqwN4jGIB8R0YYn3QwsrsHLoi3iOXPYHxrjQhrn552NEfte5ap
         pl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713587080; x=1714191880;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/esIK52jSr8O9hdbHulpIcvgI+D8w5KpuBs8WBK9fds=;
        b=S0Z6mYb/x4Jab0mbi4broh6fj6J5UgJttxAqUtU0cwPLl20XfhS+gDyEXXYVDdfrz3
         u/u36iUm3n/4fuqoNFRYqqHY3kUi5m41bgwjdimJpJe4qmDCFWGY0YD0OeoQ7KHuuf7g
         I4GVVF5LHOkEFJtoonIFs7bI4FU+kxneZnQGHW8AYbPxtOY7kNxpYCDWUgT65s4O+Dfx
         klhdowFLeS0HvQVpcBirH8zEVH3GWCj65OZEZ3TgmjmxoNjPabrdeThUa95AGZ3zcw4P
         SgFQmIry6NxR6U25Fss2M2BhanqiJ6bGqCZrABqbciFdUfNvBFDacEmHOnORDiBXF8tj
         JG1Q==
X-Gm-Message-State: AOJu0YxOLTvnzcOeuKHcD566RBV/KCRL0krexByJdINXbGhiDbVMuaR4
	/QLaB+55BAiz63PVZUrP1UX+W/T1wHEeF30rGUCvoJ4cwDBtCR5YchXY8Q==
X-Google-Smtp-Source: AGHT+IGR/gzJG4/xgCqYpNAsON6kRR1PwXA1GiER+WeVxQGD0gIs5qhQVwbbSeQvkmiXCIe3JJTnjg==
X-Received: by 2002:adf:f64c:0:b0:347:f6f8:5088 with SMTP id x12-20020adff64c000000b00347f6f85088mr2603976wrp.54.1713587080332;
        Fri, 19 Apr 2024 21:24:40 -0700 (PDT)
Received: from ?IPV6:2001:8a0:6cd2:9000:fcd3:5ad9:1c38:c608? ([2001:8a0:6cd2:9000:fcd3:5ad9:1c38:c608])
        by smtp.gmail.com with ESMTPSA id cg5-20020a5d5cc5000000b00343dc6a0019sm5841610wrb.68.2024.04.19.21.24.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 21:24:39 -0700 (PDT)
Message-ID: <e2fc64fc-1615-4b3a-8f43-0aab8ff77d69@gmail.com>
Date: Sat, 20 Apr 2024 05:24:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Andr=C3=A9_Coelho?= <andrealbergaria@gmail.com>
Subject: instead of use linked lists, why not use arrays?!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

instead of linked list, could we use arrays instead? better performance, 
i guess :))


later

andre

-- 
André Albergaria Coelho
andrealbergaria@gmail.com


