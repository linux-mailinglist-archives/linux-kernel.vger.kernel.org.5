Return-Path: <linux-kernel+bounces-95056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EFA8748B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86DBB22B16
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CED629FD;
	Thu,  7 Mar 2024 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skRAZUVe"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F84B5FDCC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796598; cv=none; b=cARBJYC3rN7jLzHoyeewl+HMXpd/mlrdiZSFOi5A21dQeg6dvZ4hDcqM3J35dkNsYsCLDUTor61d5VdHYrh4Nd1ue0OvFjxShSE/WoidIErdGHGJ8ImeTro4ODtc37y/ZMsoTURSiYB6ZnGvZgZ22mxoWdDup1aJOF7R0GlmhYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796598; c=relaxed/simple;
	bh=bSM3ySkxuhJbqbzz53H18Qqk1TGUit4TtwSmY4Cd/fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQ6mcMmC6F9MznBcMLHw1ucVKWKFrRkoYghAke1O3dl2jElyu8nUzMkUwienCJ0LOvDuloB8mnJK3e9kCbyTzh/RP7hfdcV40raq1wxq7zdGan9x4Tv8ax/kKZHE75tXJ1XQlZz4IJjAXj5CFnveAw0ucAiVADMCqhqGiibMrlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=skRAZUVe; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso565934276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 23:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709796595; x=1710401395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ivNWvY9J61C/Vr2L/OIMeKBJWQceFrpq54G2afsNiFk=;
        b=skRAZUVez+Q3/E9d6ziV8S5sYm4GLHVZYB3rkO3UNVNwnKgt+xRJ8MsSN5beKVPNPL
         PRS190qnnPo7TmopfDCSwA91avpRArD2/pvHF2Y5puqaOA8wmOMO8L2YjapYEFmw9/uU
         D8z/GTnSU3aaPAQes2i26EeeL9m1wn/wUwYaaZIslX+7CKAdNNtfRSMvdzl9d/+4gwPg
         ZTNDushQWJDxitagRU8Y7KiTZerEVb99mM4gfb8Ii8fNwuqe9g8lFR/TTg3t0e2rlE56
         7oyA6PR5bkJQecemTUaj6sMWgbi4XZsFVtbzGYWS8Hd6JF2E2RhtS6OK/gIUTOMcWvZY
         +ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709796595; x=1710401395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivNWvY9J61C/Vr2L/OIMeKBJWQceFrpq54G2afsNiFk=;
        b=SEq+620an7KS1g5FIl0LXbxB37trvv3SndChyQsGR7K7J4yi3YBbH/IqwsEe6ByvLZ
         85QP+I+oJisF0cIGCiLqR7wphYYZWVyTHC38EuYd/2xYgjkmcHq5DXgr3ZuHnB9ghuQg
         QiUA4iIlpqfQRHpCko/35zINdNE9L8/4GU1bDrWGsWUynuQDqa+pUCZA4DIDOoL9sunU
         C5cWjTNlNrd0ovjZHSn4J5EZXnVheKA0wtYnTp4R/+8KSLBTlCejmoX7XT6tVhoEdXiw
         cq3orXPc5V2F1+9rF1ZrA71xBUd8HV+n/oVbfVX4Y1QUSr6gzhIlaFyguk5YoSFRn/n8
         +o6w==
X-Forwarded-Encrypted: i=1; AJvYcCWLBej3i6/L26hJnJpDk+SHeI1o2QJzSpqomZIUUfNsJj9n3vqBYzhtSqTu+4Zq2nGGp5g+rqJVDtewcwY7pMyet1xolQN0nJouNi7x
X-Gm-Message-State: AOJu0Yyvs+T+3qo0oPiVON6MuPwTGi8x42yxsIVcaE7vvZYoMZNRNtFt
	OKLpESmBzfgoV8hlJQt/J+gxvpUije78N0FbWF65NtRxISbCyvsq3zfORGx4+jAFtrVFmEMs39Y
	vksse2EQw7AWt2EHOY7cMGPOuiO/hMV0YPtNJnQ==
X-Google-Smtp-Source: AGHT+IHz9T+wdq3Ux69tJgjFTjX1cQdWvWqR9PR2o0pf0rlixD+zc1omJVthOzxQDeQ36Qf9wgf0cGiBjA+biewE+Fk=
X-Received: by 2002:a25:fd6:0:b0:dc2:5674:b408 with SMTP id
 205-20020a250fd6000000b00dc25674b408mr13753108ybp.57.1709796595612; Wed, 06
 Mar 2024 23:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA8EJpoghqa5r2vc5XXdfVJy1WDBysXs4LdMybgdgqMTcEPDfA@mail.gmail.com>
 <20240307030219.92701-1-amadeus@jmu.edu.cn>
In-Reply-To: <20240307030219.92701-1-amadeus@jmu.edu.cn>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 09:29:44 +0200
Message-ID: <CAA8EJpp++=NLZVv7we3Cwz+G7vL9xFoXqHgsMyQZ8tgdNHKcyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU Frequency
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 05:02, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Hi, Dmitry
> > I did before writing the comment. You have the only IPQ6000 case, it
> > sets  drv->versions = IPQ6000_VERSION = BIT(2) = 0x4. So, as I said,
> > you are enabling this for all IPQ6000 SoC versions, unless I miss
> > something.
>
> Sorry, I didn't explain it clearly.
> In fact, there are some ipq6000 SoCs whose msm_id is QCOM_ID_IPQ6018.
> But the chip screen printing is ipq6000.
> OEM boot log: `CPU: IPQ6018, SoC Version: 1.0`
> For these SOCs, I tested the frequency is up to 1.5GHz.

So... Do you consider this SoC to be IPQ6018 or IPQ6000?
And anyway, this should be explained in the commit message. Otherwise
anybody reading the commit will have the same questions as I do.

-- 
With best wishes
Dmitry

