Return-Path: <linux-kernel+bounces-23802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C2F82B1EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FE4284C10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1EB4CDE2;
	Thu, 11 Jan 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="A2oBNdBK"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0E4CB53
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbd6e37af4so4335169b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1704987411; x=1705592211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDFuvNPB2cG7HqrV8iXyazQ/HuolZ9Qbba8cNo3np68=;
        b=A2oBNdBKcv0jsAfvcLz/hqL5HrxD2FMDCDZM7d0dlUYwITTx5+zDIYpou+BgobbdLn
         bl+fO3JzM4qJKo2iXrB3mgfOLVIEeqYc4oaDOuaV2k/bI0uClWDzDd1ihXVpyNIVrteK
         cS1+3a+ovqgZvNFNeZd/EkSUR351XF70V57/+RAJsUXxgz0OjdfyWTR8kzBd8AyeEalx
         G31BrgzNcwLjKcMQzuWzfYwYD/0V0qOTyaFCHTqrpjJJUQ8ew9qCEg4S6ZSKYGTF3AeB
         sttjmqmTtrQEui0Zh9SLV3aUNy4sK6HRV2YZg/SayYR3f19kjRvuuN3a/iNW2kluQwgh
         YU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704987411; x=1705592211;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDFuvNPB2cG7HqrV8iXyazQ/HuolZ9Qbba8cNo3np68=;
        b=c4sofbvdi7+LabMUsEAV25Ixro5mNspIp0o1KJ1rltthINJQesJh79JAflfrdIN3PO
         ExrSK9oVv0N4l1KPN5jQ+AH6J5W+Fam4oFWZtJaAKdl3ePuEaBcOTMNQCJchPSW0R+QW
         Fp5pqgAZqSHET0BwGtgDy9ohidmWtS6BhwEU5wB2pSEtrI7YdEjDwabC7y0O/HNaPGC8
         8gwWzWC1clhROkMO2nQVG4oJ8xmDsYkifVPuuudacAWEantCpO5ebjzS/7bfHNH2y3YD
         ibxRVlCgy0Vr0RUEmB8gM/Q6/ILsFehK7/YuhKIXuS4VK4opnR7OcmSSnO32wVSEXlWh
         Xutg==
X-Gm-Message-State: AOJu0Ywt9DzZXtowUBSOrXH85vg3DxF9OO+OuRymlKSc8wkP0YmIitAB
	OXoLPjMbAbWpQApMJxJrzilccKhrXdBDgw==
X-Google-Smtp-Source: AGHT+IHFGQG4mYWsTOS7Vn8HQB4sQWmCgmeEuSLKMJpaTmMUXTDnnIj8S2m8kVoqKUZ8aAuj+ui98A==
X-Received: by 2002:a05:6808:15a6:b0:3bd:49b0:4364 with SMTP id t38-20020a05680815a600b003bd49b04364mr1675979oiw.95.1704987410996;
        Thu, 11 Jan 2024 07:36:50 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d3-20020a05680813c300b003bc1060d1dbsm192309oiw.57.2024.01.11.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 07:36:50 -0800 (PST)
Date: Thu, 11 Jan 2024 07:36:50 -0800 (PST)
X-Google-Original-Date: Thu, 11 Jan 2024 07:36:40 PST (-0800)
Subject:     Re: [PATCH] riscv: vector: Check SR_SD before saving vstate
In-Reply-To: <CABgGipX7Jf7M8ZYgeRPcE9tkzc7XWpfWErsiacn2Pa9h=vG2cQ@mail.gmail.com>
CC: patchwork-bot+linux-riscv@kernel.org, songshuaishuai@tinylab.org,
  linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  greentime.hu@sifive.com, Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org,
  Bjorn Topel <bjorn@rivosinc.com>, xiao.w.wang@intel.com, heiko@sntech.de, ruinland.tsai@sifive.com,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: andy.chiu@sifive.com
Message-ID: <mhng-089c592d-dc14-4eec-a367-95745c844d42@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 11 Jan 2024 07:16:06 PST (-0800), andy.chiu@sifive.com wrote:
> Hi Palmer,
>
> On Thu, Jan 11, 2024 at 10:50 PM <patchwork-bot+linux-riscv@kernel.org> wrote:
>>
>> Hello:
>>
>> This patch was applied to riscv/linux.git (for-next)
>
> IIUC the conclusion for this thread is not to check SD bit for either
> vector or fpu. The patch for this was sent together with the
> kernel-mode vector series and has been reviewed-by both Song and Guo.
>
>> by Palmer Dabbelt <palmer@rivosinc.com>:
>>
>> On Thu, 21 Dec 2023 15:04:49 +0800 you wrote:
>> > The SD bit summarizes the dirty states of FS, VS, or XS fields,
>> > providing a "fast check" before saving fstate or vstate.
>> >
>> > Let __switch_to_vector() check SD bit as __switch_to_fpu() does.
>> >
>> > Fixes: 3a2df6323def ("riscv: Add task switch support for vector")
>> > Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
>> >
>> > [...]
>>
>> Here is the summary with links:
>>   - riscv: vector: Check SR_SD before saving vstate
>>     https://git.kernel.org/riscv/c/e1b76bc00ed1
>>
>> You are awesome, thank you!
>> --
>> Deet-doot-dot, I am a bot.
>> https://korg.docs.kernel.org/patchwork/pwbot.html
>>
>>
>
> Please let me know if I missed anything.

Sorry, I must have misunderstood.  I'm dropping it.

