Return-Path: <linux-kernel+bounces-41854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BA783F8AF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6F41F22234
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1B745975;
	Sun, 28 Jan 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6mMHl3C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512BA446CB;
	Sun, 28 Jan 2024 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463967; cv=none; b=e47m8DkbJJa60X1fj9Su9cDmcON7SjmRqW9E+X7nYfEy1neYxvrOYKNeIxT5gDxCElCAez15svp4H4YPoj0Ou5r+4X9E7KI6bwEhTGTCx+bHCjE0inIuPdx7+82UkM4jNZzgFrZ6PDgMtSyQHj1ouJA6uJZXlJlIsuK7r1/dlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463967; c=relaxed/simple;
	bh=djfj4kZU5WCPozAnBo33L2Pox+OBwFS43H2QdrhL9NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgGy8S4yXoSTMatj1aw7Rgznr2bIZCui9CJmG8ZCTb2paDgOSf7ELM35O06E8EjDVLNTqnELpsVxV8l4RWAvaMJduvfFp4Q2lm/SjjtMSr6hboj7SYr8pTyG4Jo6QhSsZzlbJ87cUnl9hccpDZnwG4H126Mv76nYoIT1Vad5v3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6mMHl3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A596C43394;
	Sun, 28 Jan 2024 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463966;
	bh=djfj4kZU5WCPozAnBo33L2Pox+OBwFS43H2QdrhL9NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6mMHl3C8wLD4wXEpPYHhyeAE49vnusCXYzxLvGLqnI1q+M2JfVRPGMWA/gFFIr0M
	 UFm4z1eqI+bTdYFSRUzuGmfBtwdtoqPB0+KKsfX8MGDLrIS6V3I6k6QJZr7rEdXVAG
	 5Ooe8lhTaTU7FpU8hxHH96TkjbsCcC1F1lG5yRMFBY6dLkLxwFGB8JKiX6YiHEuIDl
	 pRss/8hnlZUI02aFI2L55wMU7x5omMDdGrjOMqfED48fLrf9iaIjNXRRWVnJZA7Qe8
	 vkPWG25ty7j5aakPz8ZIPjqHVmSHBjQH0zJLSX/gmHgE284/jwTmD1iV2GnoulOmf5
	 2TkQD8r5yfdmw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_clew@quicinc.com
Subject: Re: [PATCH v2] soc: qcom: aoss: Add tracepoints in qmp_send()
Date: Sun, 28 Jan 2024 11:45:49 -0600
Message-ID: <170646395046.64610.1519604817263643859.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123-qcom-aoss-tracepoints-v2-1-bd73baa31977@quicinc.com>
References: <20240123-qcom-aoss-tracepoints-v2-1-bd73baa31977@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 23 Jan 2024 19:40:33 -0800, Bjorn Andersson wrote:
> Add tracepoint for tracing the messages being sent and the success
> thereof. This is useful as the system has a variety of clients sending
> requests to the always-on subsystem.
> 
> 

Applied, thanks!

[1/1] soc: qcom: aoss: Add tracepoints in qmp_send()
      commit: 651893a7c99ad935de24792bf2019c00ee2fca10

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

