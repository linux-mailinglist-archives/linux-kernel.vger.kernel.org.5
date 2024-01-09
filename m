Return-Path: <linux-kernel+bounces-21486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFD0829019
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9CC2887BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D293E47B;
	Tue,  9 Jan 2024 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eY2Y4WXz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6FC25742;
	Tue,  9 Jan 2024 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704840962; x=1736376962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kpx/lPgLBKAaAsqKFr33cZwVRVu3uM5SxrSZY3S4OpE=;
  b=eY2Y4WXzxN8sL0hSjbZrGn0x8Cfnu55nr8z7IZCHde933ajR/7e3ySLJ
   CgB7t/29FKi0e1FrhPkvVaTsllj7ioEqFkdjt1F8ppT+QnU/FccHxrjaU
   fdPp3EXGp5Yo5LpqdwR1H75uSe0QZtz5KTpLyJOP8dmeO6A/yIRa2bxMk
   3Q8gF6l1rjNI6Kag9gpEoVZUcLha3evnu9Phu9lexbA++EpcaCi4i74o/
   LvOGbC4lbWBNQZYxrXLpu4RD+Htsv93ni1S3SexPrilJxV6BmIaPkULQM
   17M4m1CsJUVSToOZ4Ddgp2WsfCLK85nbLTqTl3IYptEDbzEAze6iwyzoD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5118876"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5118876"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 14:56:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="872399253"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="872399253"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jan 2024 14:55:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNL0k-0006Kk-3C;
	Tue, 09 Jan 2024 22:55:54 +0000
Date: Wed, 10 Jan 2024 06:55:22 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, edumazet@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [PATCH] net: tcp: accept old ack during closing
Message-ID: <202401100650.fcRuth6J-lkp@intel.com>
References: <20240109031204.15552-1-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109031204.15552-1-menglong8.dong@gmail.com>

Hi Menglong,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master horms-ipvs/master v6.7 next-20240109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/net-tcp-accept-old-ack-during-closing/20240109-111438
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240109031204.15552-1-menglong8.dong%40gmail.com
patch subject: [PATCH] net: tcp: accept old ack during closing
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240110/202401100650.fcRuth6J-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401100650.fcRuth6J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401100650.fcRuth6J-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ipv4/tcp_input.c:6716:26: error: too few arguments provided to function-like macro invocation
           SKB_DR_SET(NOT_SPECIFIED);
                                   ^
   include/net/dropreason-core.h:418:9: note: macro 'SKB_DR_SET' defined here
   #define SKB_DR_SET(name, reason)                                \
           ^
>> net/ipv4/tcp_input.c:6716:2: error: use of undeclared identifier 'SKB_DR_SET'
           SKB_DR_SET(NOT_SPECIFIED);
           ^
   2 errors generated.


vim +6716 net/ipv4/tcp_input.c

  6611	
  6612	/*
  6613	 *	This function implements the receiving procedure of RFC 793 for
  6614	 *	all states except ESTABLISHED and TIME_WAIT.
  6615	 *	It's called from both tcp_v4_rcv and tcp_v6_rcv and should be
  6616	 *	address independent.
  6617	 */
  6618	
  6619	int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
  6620	{
  6621		struct tcp_sock *tp = tcp_sk(sk);
  6622		struct inet_connection_sock *icsk = inet_csk(sk);
  6623		const struct tcphdr *th = tcp_hdr(skb);
  6624		struct request_sock *req;
  6625		int queued = 0;
  6626		bool acceptable;
  6627		SKB_DR(reason);
  6628	
  6629		switch (sk->sk_state) {
  6630		case TCP_CLOSE:
  6631			SKB_DR_SET(reason, TCP_CLOSE);
  6632			goto discard;
  6633	
  6634		case TCP_LISTEN:
  6635			if (th->ack)
  6636				return 1;
  6637	
  6638			if (th->rst) {
  6639				SKB_DR_SET(reason, TCP_RESET);
  6640				goto discard;
  6641			}
  6642			if (th->syn) {
  6643				if (th->fin) {
  6644					SKB_DR_SET(reason, TCP_FLAGS);
  6645					goto discard;
  6646				}
  6647				/* It is possible that we process SYN packets from backlog,
  6648				 * so we need to make sure to disable BH and RCU right there.
  6649				 */
  6650				rcu_read_lock();
  6651				local_bh_disable();
  6652				acceptable = icsk->icsk_af_ops->conn_request(sk, skb) >= 0;
  6653				local_bh_enable();
  6654				rcu_read_unlock();
  6655	
  6656				if (!acceptable)
  6657					return 1;
  6658				consume_skb(skb);
  6659				return 0;
  6660			}
  6661			SKB_DR_SET(reason, TCP_FLAGS);
  6662			goto discard;
  6663	
  6664		case TCP_SYN_SENT:
  6665			tp->rx_opt.saw_tstamp = 0;
  6666			tcp_mstamp_refresh(tp);
  6667			queued = tcp_rcv_synsent_state_process(sk, skb, th);
  6668			if (queued >= 0)
  6669				return queued;
  6670	
  6671			/* Do step6 onward by hand. */
  6672			tcp_urg(sk, skb, th);
  6673			__kfree_skb(skb);
  6674			tcp_data_snd_check(sk);
  6675			return 0;
  6676		}
  6677	
  6678		tcp_mstamp_refresh(tp);
  6679		tp->rx_opt.saw_tstamp = 0;
  6680		req = rcu_dereference_protected(tp->fastopen_rsk,
  6681						lockdep_sock_is_held(sk));
  6682		if (req) {
  6683			bool req_stolen;
  6684	
  6685			WARN_ON_ONCE(sk->sk_state != TCP_SYN_RECV &&
  6686			    sk->sk_state != TCP_FIN_WAIT1);
  6687	
  6688			if (!tcp_check_req(sk, skb, req, true, &req_stolen)) {
  6689				SKB_DR_SET(reason, TCP_FASTOPEN);
  6690				goto discard;
  6691			}
  6692		}
  6693	
  6694		if (!th->ack && !th->rst && !th->syn) {
  6695			SKB_DR_SET(reason, TCP_FLAGS);
  6696			goto discard;
  6697		}
  6698		if (!tcp_validate_incoming(sk, skb, th, 0))
  6699			return 0;
  6700	
  6701		/* step 5: check the ACK field */
  6702		reason = tcp_ack(sk, skb, FLAG_SLOWPATH |
  6703					  FLAG_UPDATE_TS_RECENT |
  6704					  FLAG_NO_CHALLENGE_ACK);
  6705	
  6706		if (reason <= 0) {
  6707			if (sk->sk_state == TCP_SYN_RECV)
  6708				return 1;	/* send one RST */
  6709			/* accept old ack during closing */
  6710			if (reason < 0) {
  6711				tcp_send_challenge_ack(sk);
  6712				reason = -reason;
  6713				goto discard;
  6714			}
  6715		}
> 6716		SKB_DR_SET(NOT_SPECIFIED);
  6717		switch (sk->sk_state) {
  6718		case TCP_SYN_RECV:
  6719			tp->delivered++; /* SYN-ACK delivery isn't tracked in tcp_ack */
  6720			if (!tp->srtt_us)
  6721				tcp_synack_rtt_meas(sk, req);
  6722	
  6723			if (req) {
  6724				tcp_rcv_synrecv_state_fastopen(sk);
  6725			} else {
  6726				tcp_try_undo_spurious_syn(sk);
  6727				tp->retrans_stamp = 0;
  6728				tcp_init_transfer(sk, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB,
  6729						  skb);
  6730				WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
  6731			}
  6732			tcp_ao_established(sk);
  6733			smp_mb();
  6734			tcp_set_state(sk, TCP_ESTABLISHED);
  6735			sk->sk_state_change(sk);
  6736	
  6737			/* Note, that this wakeup is only for marginal crossed SYN case.
  6738			 * Passively open sockets are not waked up, because
  6739			 * sk->sk_sleep == NULL and sk->sk_socket == NULL.
  6740			 */
  6741			if (sk->sk_socket)
  6742				sk_wake_async(sk, SOCK_WAKE_IO, POLL_OUT);
  6743	
  6744			tp->snd_una = TCP_SKB_CB(skb)->ack_seq;
  6745			tp->snd_wnd = ntohs(th->window) << tp->rx_opt.snd_wscale;
  6746			tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
  6747	
  6748			if (tp->rx_opt.tstamp_ok)
  6749				tp->advmss -= TCPOLEN_TSTAMP_ALIGNED;
  6750	
  6751			if (!inet_csk(sk)->icsk_ca_ops->cong_control)
  6752				tcp_update_pacing_rate(sk);
  6753	
  6754			/* Prevent spurious tcp_cwnd_restart() on first data packet */
  6755			tp->lsndtime = tcp_jiffies32;
  6756	
  6757			tcp_initialize_rcv_mss(sk);
  6758			tcp_fast_path_on(tp);
  6759			break;
  6760	
  6761		case TCP_FIN_WAIT1: {
  6762			int tmo;
  6763	
  6764			if (req)
  6765				tcp_rcv_synrecv_state_fastopen(sk);
  6766	
  6767			if (tp->snd_una != tp->write_seq)
  6768				break;
  6769	
  6770			tcp_set_state(sk, TCP_FIN_WAIT2);
  6771			WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
  6772	
  6773			sk_dst_confirm(sk);
  6774	
  6775			if (!sock_flag(sk, SOCK_DEAD)) {
  6776				/* Wake up lingering close() */
  6777				sk->sk_state_change(sk);
  6778				break;
  6779			}
  6780	
  6781			if (READ_ONCE(tp->linger2) < 0) {
  6782				tcp_done(sk);
  6783				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
  6784				return 1;
  6785			}
  6786			if (TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq &&
  6787			    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
  6788				/* Receive out of order FIN after close() */
  6789				if (tp->syn_fastopen && th->fin)
  6790					tcp_fastopen_active_disable(sk);
  6791				tcp_done(sk);
  6792				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
  6793				return 1;
  6794			}
  6795	
  6796			tmo = tcp_fin_time(sk);
  6797			if (tmo > TCP_TIMEWAIT_LEN) {
  6798				inet_csk_reset_keepalive_timer(sk, tmo - TCP_TIMEWAIT_LEN);
  6799			} else if (th->fin || sock_owned_by_user(sk)) {
  6800				/* Bad case. We could lose such FIN otherwise.
  6801				 * It is not a big problem, but it looks confusing
  6802				 * and not so rare event. We still can lose it now,
  6803				 * if it spins in bh_lock_sock(), but it is really
  6804				 * marginal case.
  6805				 */
  6806				inet_csk_reset_keepalive_timer(sk, tmo);
  6807			} else {
  6808				tcp_time_wait(sk, TCP_FIN_WAIT2, tmo);
  6809				goto consume;
  6810			}
  6811			break;
  6812		}
  6813	
  6814		case TCP_CLOSING:
  6815			if (tp->snd_una == tp->write_seq) {
  6816				tcp_time_wait(sk, TCP_TIME_WAIT, 0);
  6817				goto consume;
  6818			}
  6819			break;
  6820	
  6821		case TCP_LAST_ACK:
  6822			if (tp->snd_una == tp->write_seq) {
  6823				tcp_update_metrics(sk);
  6824				tcp_done(sk);
  6825				goto consume;
  6826			}
  6827			break;
  6828		}
  6829	
  6830		/* step 6: check the URG bit */
  6831		tcp_urg(sk, skb, th);
  6832	
  6833		/* step 7: process the segment text */
  6834		switch (sk->sk_state) {
  6835		case TCP_CLOSE_WAIT:
  6836		case TCP_CLOSING:
  6837		case TCP_LAST_ACK:
  6838			if (!before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
  6839				/* If a subflow has been reset, the packet should not
  6840				 * continue to be processed, drop the packet.
  6841				 */
  6842				if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk, skb))
  6843					goto discard;
  6844				break;
  6845			}
  6846			fallthrough;
  6847		case TCP_FIN_WAIT1:
  6848		case TCP_FIN_WAIT2:
  6849			/* RFC 793 says to queue data in these states,
  6850			 * RFC 1122 says we MUST send a reset.
  6851			 * BSD 4.4 also does reset.
  6852			 */
  6853			if (sk->sk_shutdown & RCV_SHUTDOWN) {
  6854				if (TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq &&
  6855				    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
  6856					NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
  6857					tcp_reset(sk, skb);
  6858					return 1;
  6859				}
  6860			}
  6861			fallthrough;
  6862		case TCP_ESTABLISHED:
  6863			tcp_data_queue(sk, skb);
  6864			queued = 1;
  6865			break;
  6866		}
  6867	
  6868		/* tcp_data could move socket to TIME-WAIT */
  6869		if (sk->sk_state != TCP_CLOSE) {
  6870			tcp_data_snd_check(sk);
  6871			tcp_ack_snd_check(sk);
  6872		}
  6873	
  6874		if (!queued) {
  6875	discard:
  6876			tcp_drop_reason(sk, skb, reason);
  6877		}
  6878		return 0;
  6879	
  6880	consume:
  6881		__kfree_skb(skb);
  6882		return 0;
  6883	}
  6884	EXPORT_SYMBOL(tcp_rcv_state_process);
  6885	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

