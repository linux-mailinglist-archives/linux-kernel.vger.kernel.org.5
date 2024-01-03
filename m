Return-Path: <linux-kernel+bounces-15835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F279823419
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7781C2354A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6812E1C69A;
	Wed,  3 Jan 2024 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="EYDzObdr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205211C680;
	Wed,  3 Jan 2024 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704305302; x=1704910102; i=rwarsow@gmx.de;
	bh=XgIomNQU40rhAEDA8HFv5+/yl6BS6ns2p944vemrwgQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=EYDzObdre+YF/fxlR3Ya3NGjKCpP8A65T2Ce0EV/S27lbzS+0Q2eoVzZneOzbvEC
	 s9JDDjX7eW5Z1jsXlos3Ricc7hxiqISZY3qxUVjK2VzhveXZr9dl1pTuUrbbKaETm
	 uuxlrRRFemSsxgVEp4h6SGcUJFHCn0MtLI6pMOaE4L3m9xC7brNUn0bfLsZKi+2aG
	 3l7f3+ZNhqB9D3XMiqqhGhWBSCsHnRsNxth0iyRXr3YXAVwd4W3oAdu31/QHUc1yC
	 EudFzqXinHLSr/L5iIC+g4p73SmrJ7H3gM3OWAzfKe09PYcM8Ju6xsCkmeVRg0Qj7
	 MkDFRxPvE+cnsfUo1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.252]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1reQ242IwA-00LUPu; Wed, 03
 Jan 2024 19:08:22 +0100
Message-ID: <101416fe-340c-4db6-861a-46605ea64a4c@gmx.de>
Date: Wed, 3 Jan 2024 19:08:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tVT42VbHow6gVPUTg97P61FETnY0iS6+LSKWfgrTk3d+kkbnFqr
 Jc2SV7ogr3BhQO7Q2eZmxU336hVh4NiC/lvh0YFmtQGzwWPisXjKkM3tTlHsZ1U6zDHEKbL
 /IzbwDqFEJeadhJ4xdIqZ7pxJDlEfFbBipc74mStL8qcug8NMv6OqPOl3uDjrQoy0GljqYb
 TUUTWtBYJwOXIPtSatn4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:St/caKJKSXU=;RHjLT/TLebGKC8DYIJPDg7q31GV
 fpdDsJkhSNVOpQEmG1CNap5lVK0wlrOBGq3Kk4elSWbghnF/pSJh0rJWJqH+9scdN5WxLeBXN
 bjLbufmZELkJUpwSdSRVZeb/2EEc6tVGB4ZFnsacOmfgnY8RXoxbQMN2c8tWMnFcgVQuXW11A
 hLyTfjd4oKdTUjfVawszIa3XI4k3mbvErJ8aJkbdyVxhU8Y4g0ekiZGVobhPjou/kU5y5Tjzz
 GWuMWaatctVgtz0xQvZsXLgoXIOTaBG3SSdU4TSvz+U47GWTrEKhBhWfFcVFSmiOGRZn5f4+B
 /FwNJqyB7kEXpqp30u6BXnZmdTNGiKIo6l0Ti0HGUXCg6hKPcU6VRiBbvDudNa5riDgjJVcWC
 299LGke/qBV3gWJgd7qwqbE8jLi+HibYytdozUdfpK7toNZmI9WKnOB5HCeaoJhVBvWpljx8t
 b4RpT3TODWQgdtN1Wh2e41SMJJdCTlLFTDIXjh3KiC+dNbShuaajsKKIqpERMiF563ZFLDh7+
 OPDKYMRAXz011m1jNZQCNQmbb1PD6L4cGyTyxHcctg7m+nC1gph7RMSgNeqAbHgr9KVi9rPFh
 37KCT/iO0PRUdcrjGyFtBiEqGwPbWDEuwawhlGdC+DABakH9yCfMu46VUJFZhpXOrxA55/6QG
 VJXSBHcIeOdhQ1Ocq41PEtcCP6Agxc7xkF++/N86nnDEeNKaW1zITxvkEytCcAlxk9L7TPteU
 8w1MOSnrJ3SaLCyayOMuvZjClx+VRx8m2w6ut6iO1lXESkDgudWWswzMD9XHX4BsRzUrk4dIr
 poDhvPTKFZ3dRfwaRU5BLo1ETBowpFYpL2Lf+1aEXZPvFl4Kt70Nk2qdyY9dVQqtIjyqmC7Hk
 rOWK7Tcu/Ka9YvFjABzlWco/E0Mv6vM56uJxfpGzOfyyfdfn8hVBSK0pToGdHcgor8l7wm5ex
 PX2HqQ==

Hi Greg

no regressions here on x86_64
(Intel Rocket Lake: i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


