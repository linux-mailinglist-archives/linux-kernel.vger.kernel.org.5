Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4D675B84E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjGTTwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGTTwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:52:33 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEDD1733;
        Thu, 20 Jul 2023 12:52:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689882749; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fANkh1ARs+GD7Fi+eWLfTU5Ma6u9ffKtiwvbTjZ+eiJjjTbtEm34yrA2A7MtcnOo2N
    YY4gSq2BWMKiZ5oWdgExV1EK/OCD+8UzZB+hbOccWKrGGNulg6kMf5ZA5/SVgxVtnt4W
    8BlXluGusLE+sx45RSIHh6N4WAmWUNzbrHN0txsHKNXNO2y9ZO4P5xcSGID2IvISxopF
    KYQbOBMS6ZM+GX99ECU7M2gc1H01jLPq5oIZ6gmATKjd89uaAc7ITdXw9gazgg0adKTx
    6NzND+yq09R0PBQK0XrKGC6LdwqovQg7sdFaDgESOo2UfH64elfBdmMIYpRjvnhszthA
    RE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689882749;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=YkvSR1NBpdfO6+oRs6OkZ9rZa0nqSApvjTAua18PIhI=;
    b=i0Uix2EWgEzK1hZGXeFA44zJ5SCtlpbjeKoikhpMw8qJSaYVOUCmVtQ16azwnR7goF
    ba4rmr5GPO0/uJWXqinfE4fd+e3G9D3XW3iG2zWyIy0uso367/PAMuuy/+h4QCHb9V6P
    6v/g+2g7a95wW+XikakBIuEzecXIXQDsUFQyhhmrD7ZpTKqa5oNKbwkbDZPt0iHQMbOS
    3RS7/CUJ1CGFYxYQRVHUer+tMyuclSisVH9iyUAwNHXUuE0jWp+GyN1k8ty0POq8vKfj
    w+LRSfS1D9jKbXWooS/5wgQLyJiVD+UPQ9aM9pFO0cOpEjGJVjBUvUhx2zWs8qGwfrUl
    QF5w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689882749;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=YkvSR1NBpdfO6+oRs6OkZ9rZa0nqSApvjTAua18PIhI=;
    b=ELQaHyx7DTOl1p1prb0HYFs6+clk9YKeBbcQ6HyK0mTouTVh7P1AnUvlFK+WwybQdT
    Rc1vh3Y9PMSuY7eIpCjPEF1fwtI5Zdkq0IQgG89dnbGcG7yws2z2rYirKy31LwgQF1Xi
    XgKSN1fpZSoBk0P86apTYlel8oHcAaepLFkzufrBDG9W1t1IWvHTohfqvqKGdya4LS63
    6d4zDN/KzyihRzpJQvWuD0AeGEpaHGhuItXanAnLkUBCh6MiDYBDV/lOiuDzzTNaBOBM
    YxTz/j0Oxl2aCTlY0e7wInnv/cSzjXB0oa4gbHKI59wm1JOFrX+z9LoYOVWOubWpfqI4
    r8kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689882749;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=YkvSR1NBpdfO6+oRs6OkZ9rZa0nqSApvjTAua18PIhI=;
    b=RdwBlnFc0f/lQvrM5sQJzjTX/Py3dSVfRlgxesVFRllDdGuSn0wofhB8H+SBbjmd6Z
    rBhwZHZoqX3Eup6gldCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA9Zfh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.4 DYNA|AUTH)
    with ESMTPSA id V0b383z6KJqT5ow
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 20 Jul 2023 21:52:29 +0200 (CEST)
Date:   Thu, 20 Jul 2023 21:52:22 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: qcm2290: Enable sync state
Message-ID: <ZLmQdjDgIbbhyTMJ@gerhold.net>
References: <20230720-topic-qcm2290_icc-v1-0-7f67f2e259c1@linaro.org>
 <20230720-topic-qcm2290_icc-v1-2-7f67f2e259c1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720-topic-qcm2290_icc-v1-2-7f67f2e259c1@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 08:24:01PM +0200, Konrad Dybcio wrote:
> Very surprisingly, qcm2290 does not seem to require any interface
> clocks.

What does this mean exactly? The interconnect .sync_state() is
responsible to drop the initial maximum bandwidth votes, with the
assumption that all active devices have voted for the bandwidth they
need. How does this relate to "requiring interface clocks"?

> It's therefore safe to enable sync_state to park unused devices.
> Do so.

Doesn't this make everything painfully slow? There are no interconnect
consumers at all in qcm2290.dtsi. I would expect that all bandwidths
end up at minimum.

Thanks,
Stephan
